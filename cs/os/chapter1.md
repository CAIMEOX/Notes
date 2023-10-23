# Chapter 1 - Basic Application and environment
## Run RustSBI
The RustSBI in repo has unexpected behavior. To fix this, I downloaded a new rustsbi-qemu release and replaced the in `bootloader`.

Set log level to `TRACE`
```
make run LOG=TRACE
```

> note: exit qemu : Ctrl A X

## Code Tree
```
├── Cargo.lock
├── Cargo.toml
├── Makefile
├── src
│   ├── boards
│   │   └── qemu.rs
│   ├── console.rs (Console printer)
│   ├── entry.asm (Set kernel environment)
│   ├── lang_items.rs (Lang items for rust compiler)
│   ├── linker.ld (Control kernel Memory layout to enable kernel to run on qemu)
│   ├── logging.rs (Log)
│   ├── main.rs (Main)
│   └── sbi.rs (SBI wrapper)
```

## Remove standard library
Add `#![no_std]` in file header of `main.rs` to remove the std and instead use `core`

## Panic Handler
There is no panic handler in `core` hence we should create one manually.
```rust
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}
```
The `!` notation means this function is divergent.

## Minimal User Mode (in qemu)
We should provide a `_start()` for compiler
```rust 
#[no_mangle]
extern "C" fn _start() {
    loop {}
}
```
> note:
> - `no_mangle` indicate that a function or variable **should not** have its name mangled by the compiler.
> - In QEMU, user mode is a **virtualization mode** that allows running user-level processes from a different architecture than the host machine. This means that you can run programs compiled for a different architecture, such as ARM or MIPS, on a host machine that uses a different architecture, such as x86 or x86_64.

## Exit 
In the example above if you comment the loop inside `_start`, there will be a segment fault because an **exit function** is missed.

We provide one:
```rust
// System call number for exiting a program in RISC-V
const SYSCALL_EXIT: usize = 93;

fn syscall(id: usize, args: [usize; 3]) -> isize {
    let mut ret;
    unsafe {
        core::arch::asm!(
            "ecall", // triggers a system call in the RISC-V architecture
            inlateout("x10") args[0] => ret, // pass the first argument to the system call in the x10 register and receive the return value in the same register

            // Pass second and third argument in the x11 and x12 registers
            in("x11") args[1], 
            in("x12") args[2], 

            // Pass the system call number
            in("x17") id,
        );
    }
    ret
}

pub fn sys_exit(xstate: i32) -> isize {
    syscall(SYSCALL_EXIT, [xstate as usize, 0, 0])
}

#[no_mangle]
extern "C" fn _start() {
    sys_exit(9);
}
```

## System write
We can extend some basic traits in core rust to impl a `println!` macro. There's the code
```rust
// system call number for writing data to a file descriptor in RISC-V 
const SYSCALL_WRITE: usize = 64;

pub fn sys_write(fd: usize, buffer: &[u8]) -> isize {
  syscall(SYSCALL_WRITE, [fd, buffer.as_ptr() as usize, buffer.len()])
}
```

## Bare mental environment
```bash
qemu-system-riscv64 \
            -machine virt \
            -nographic \
            -bios $(BOOTLOADER) \
            -device loader,file=$(KERNEL_BIN),addr=$(KERNEL_ENTRY_PA)
```
- bios: the boot loader, RustSBI
- `KERNEL_ENTRY_PA`: option specifies the physical address where the kernel should be loaded in memory, `0x80200000` here.
- `KERNEL_BIN`: binary code of the os

## Boot Process
When booted the Program Counter points to `0x1000` and then skip to `0x80000000` of RustSBI.
After RustSBI finish initialization it will jump to `0x80200000`

```mermaid
graph LR
??? --> QEMU --> RustSBI --> OS[OS=HelloWorld]
```

## Shutdown operation
RustSBI runs on **Machine Mode** abd OS runs on **Supervisor Mode**.
```rust
const SBI_SHUTDOWN: usize = 8;

pub fn shutdown() -> ! {
    sbi_call(SBI_SHUTDOWN, 0, 0, 0);
    panic!("It should shutdown!"); // Never reach
}
```

## Set Memory Layout
Use linker script to adjust the Linker.

```toml
// os/.cargo/config
[target.riscv64gc-unknown-none-elf]
rustflags = [
    "-Clink-arg=-Tsrc/linker.ld", "-Cforce-frame-pointers=yes"
]
```

The `linker.ld` is the linker script (GNU linker script)
```linker
OUTPUT_ARCH(riscv)
ENTRY(_start)
BASE_ADDRESS = 0x80200000; 

/*
The BASE_ADDRESS variable is then defined with a value of 0x80200000. This variable is used to set the base address for the executable.
*/

/* SECTIONS of the executable */
SECTIONS
{
    /* Set the current location counter to the value of BASE_ADDRESS */
    . = BASE_ADDRESS; 
    skernel = .;

    stext = .;
    .text : {
    /* The .text.entry subsection is defined first, followed by the .text and .text.* subsections. These subsections contain the executable code. */
        *(.text.entry)
        *(.text .text.*)
    }

    . = ALIGN(4K);
    etext = .;

    srodata = .;
    .rodata : {
    /* Contains read-only data
        *(.rodata .rodata.*)
        *(.srodata .srodata.*)
    }

    . = ALIGN(4K);
    erodata = .;
    sdata = .;
    .data : {
    /* contain initialized data. */
        *(.data .data.*)
        *(.sdata .sdata.*)
    }

    . = ALIGN(4K);
    edata = .;
    .bss : {
    /* contain uninitialized data. */
        *(.bss.stack)
        sbss = .;
        *(.bss .bss.*)
        *(.sbss .sbss.*)
    }

    . = ALIGN(4K);
    ebss = .;
    ekernel = .;

    /DISCARD/ : {
        *(.eh_frame)
    }
}
```

## Stack Space Layout
Use this asm code to init the Stack.
```asm
    .section .text.entry # contains the entry point for the program
    .globl _start # make it global, hence it can be accessed from other object files
_start: # entry point
    la sp, boot_stack_top # loads the address of the boot_stack_top symbol into the stack pointer register sp
    call rust_main # call the rust_main function (defined elsewhere)

    .section .bss.stack # contains stack memory
    .globl boot_stack_lower_bound
boot_stack_lower_bound:
    .space 4096 * 16 # defines the lower bound of the stack memory (reserves 16 pages of memory for the stack. Each page is 4096 bytes in size)
    .globl boot_stack_top (defines the upper bound of the stack memory)
boot_stack_top:
```

## Clear .bss Segment
`linker.ld` gives the global symbol `sbss` and `ebss`.
```rust
pub fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    (sbss as usize..ebss as usize).for_each(|a| unsafe { (a as *mut u8).write_volatile(0) });
}
```

Well, the chapter1 ends here.
