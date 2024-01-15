# Integers and variables
## The $\mathcal{L}_{\text{var}}$ language
The $\mathcal{L}_{\text{var}}$ language extends the $\mathcal{L}_{\text{int}}$ language with variables.

The $\mathcal{L}_{\text{var}}$ language includes an assignment statement which defines a variable for use in later statements and initializes the variable with the value of an expression.

The concrete syntax:
$$
\begin{align*}
    exp &::= int | \text{input\_int}()|-exp|exp+exp|exp-exp|(exp) 
    \\
    stmt &::= \text{print}(exp)|exp
    \\
    exp &::= var
    \\
    stmt &::= var = exp
    \\
    \mathcal{L}_{\text{var}} &::=stmt*
\end{align*}
$$

## Extensible interpreters via method overriding
In this note each language builds on the prior one because there are commonalities between the interpreters.

To make interpreters extensible we need something called **open recursion** in which the tying of the recursive knot is delayed until the functions are composed.

## Definitional interpreter
The `cont` parameter is the list of statements that follow the current statement.

To accomplish a variable list we maintain a mapping from variables to values called `environment` (Use python dict)

## The x86 assembly language
We use AT&T syntax expected by the GNU assembler. 

- A program begins with the `main` label followed by a sequence of instructions.
- The `global` directive makes the `main` procedure externally visible.

The computer has a **program counter (PC)** stored in the `rip` register that points to the address of the **next** instruction to be executed.

Most x86 instructions take two operands, each of which is an integer constant (**immediate value**) or a memory location.


The syntax of the x86 asm (subset)
$$
\begin{align*}
    reg &::= \text{rsp} | \text{rbp} | \dots|\text{r8}|\dots|\text{r15}
    \\ 
    arg &::= \$int | \%reg| int(\%reg)
    \\ 
    instr &::= \text{addq}\space arg,arg|\text{subq}\space arg,arg|\text{negq}\space arg|\text{movq}\space arg,arg|\\
    & \text{callq}\space label|\text{pushq}\space arg|\text{popq}\space arg|\text{retq}
\end{align*}
$$

- There're 16 general-purpose registers in the computer. A register is denoted with a percent sign `%` followed by its name.
- The register `rsp` is called the **stack pointer** and contains the address of the item at the top of a stack.
- An immediate value is written using the notation `$n` where `n` is an integer.
- An access to memory is specified using the syntax `n(%r)` which contains the address stored in register `r` and then adds `n` bytes (1 byte = 8 bit) to the address. The resulting address is used to load or store depending on its occurrence.
- Arithmetic instruction such as `addq s,d` reads from source `s` and destination `d`, applies the arithmetic operation and then writes the result to the destination `d`.
- Last letter `q` indicates that these instructions operate on **quadwords** (64-bit values).

Example of x86 program
```asm
    .global main
main:
    movq $10, %rax
    addq $32, %rax
    retq
```
- The instruction `retq` finishes the `main` function by returning the integer in `rax` to operating system (as exit code).

- The next example program uses a region of memory called the **(procedure call) stack**. 
- The stack consists of a separate **frame** for each procedure call.
- The stack grows **downward** in memory so we increase the stack size by subtracting from the stack pointer.
- The **return address** is the location of the instruction that immediately follows the call instruction on the **caller** side. Instruction `callq` will push the return address onto the stack before jumping to the procedure.
- Register `rbp` is the **base pointer** and is used to access variables stored in the frame of the current procedure call. The base pointer of the caller is stored after the return address.

## Planning the Trip to x86
To compile one language to another we should focus on the differences between them because the compiler will need to bridge those differences.

- x86 instructions place special restrictions on their arguments.
- $\mathcal{L}_{\text{var}}$ has deeply nested expression whereas x86 has only constants, registers and memory locations as arguments.
- $\mathcal{L}_{\text{var}}$ can have any number of variables whereas x86 has only 16 registers and procedure call stack.

We break down the compiler into many steps (pass) which means we strive for each pass to accomplish one clear objective rather than two or more at the same time.

$\mathcal{L}_{\text{var}}$ consists the following passes:
- `remove_complex_operands`: To ensure every subexpression of a primitive operation or function call is a variable or integer, that is, an **atomic expression**.
- `select_instructions`: Handles the difference between $\mathcal{L}_{\text{var}}$ operations and x86 instructions. Converts each $\mathcal{L}_{\text{var}}$ operation to a short sequence of equivalent instructions.
- `assign_homes`: Replaces variables with registers or stack locations.
- `patch_instructions`: fix problems.
- `prelude_and_conclusion`