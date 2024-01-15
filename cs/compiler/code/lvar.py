from ast import *

class InterpretLint:
    def interpret_exp(self, e, env):
        match e:
            case BinOp(left, Add(), right):
                l = self.interpret_exp(left, env)
                r = self.interpret_exp(right, env)
                return l + r
            case BinOp(left, Sub(), right):
                l = self.interpret_exp(left, env)
                r = self.interpret_exp(right, env)
                return l - r
            case UnaryOp(USub(), operand):
                return -self.interpret_exp(operand, env)
            case Constant(value):
                return value
            case Call(Name('input_int'), []):
                return int(input())
            
    def interpret_stmt(self, s, env, cont):
        match s:
            case Expr(Call(Name('print'), [arg])):
                val = self.interpret_exp(arg, env)
                print(val, end='')
                return self.interpret_stmts(cont, env)
            case Expr(value):
                val = self.interpret_exp(value, env)
                return self.interpret_stmts(cont, env)
            case _:
                raise Exception('error in interpret_stmt, unexpected ' + repr(s))
            
    def interpret_stmts(self, ss, env):
        match ss:
            case []:
                return 0
            case [s, *rest]:
                return self.interpret_stmt(s, env, rest)
            
    def interpret(self, p):
        match p:
            case Module(body):
                return self.interpret_stmts(body, {})
            
def interpret_Lint(p):
    return InterpretLint().interpret(p)

class InterpretLvar(InterpretLint):
    def interpret_exp(self, e, env):
        match e:
            case Name(id):
                return env[id]
            case _:
                return super().interpret_exp(e, env)
            
    def interpret_stmt(self, s, env, cont):
        match s:
            case Assign([Name(id)], value):
                val = self.interpret_exp(value, env)
                env[id] = val
                return self.interpret_stmts(cont, env)
            case _:
                return super().interpret_stmt(s, env, cont) 


def interpret_Lvar(p):
    return InterpretLvar().interpret(p)

count = -1
def generate_name(n):
    global count
    count += 1
    return 'temp_' + str(count)


def is_atomic_single(a):
    match a:
        case Name(_):
            return True
        case Constant(_):
            return True
        case _:
            return False

def is_atomic_expr(e):
    match e:
        case UnaryOp(USub(), operand):
            return is_atomic_single(operand)
        case BinOp(l, _, r):
            return is_atomic_single(l) and is_atomic_single(r)
        case Call(Name('input_int'), []):
            return True
        case Call(Name('print'), [arg]):
            return is_atomic_single(arg)
        case _:
            return is_atomic_single(e)

def is_atomic_stmt(s):
    match s:
        case Assign([Name(id)], value):
            return is_atomic_expr(value)
        case Expr(value):
            return is_atomic_expr(value)
        case Call(Name('print'), [arg]):
            return is_atomic_expr(arg)
        case _:
            return False
        
def is_atomic_Lvar(m):
    match m:
        case Module(body):
            return all(is_atomic_stmt(s) for s in body)

class RcoLvar:
    res = []
    def rco_expr(self, e):
        if is_atomic_expr(e):
            return e
        else:
            match e:
                case UnaryOp(USub(), exp):
                    new_id = generate_name(8)
                    self.res.append(Assign([Name(new_id)], self.rco_expr(exp)))
                    return UnaryOp(USub(), Name(new_id))
                case BinOp(left, op, right):
                    lid = left
                    rid = right
                    if not is_atomic_single(left):
                        lid = Name(generate_name(8), Load())
                        self.res.append(Assign([lid], self.rco_expr(left)))
                    if not is_atomic_single(right):
                        rid = Name(generate_name(8), Load())
                        self.res.append(Assign([rid], self.rco_expr(right)))
                    return BinOp(lid, op, rid)
                case Call(Name('print'), [arg]):
                    new_id = Name(generate_name(8))
                    self.res.append(Assign([new_id], self.rco_expr(arg)))
                    return Call(Name('print'), [new_id], [])
                case _:
                    raise Exception('error in rco_expr, unexpected ' + repr(e))
            
    def rco_stmt(self, s):
        if is_atomic_stmt(s):
            self.res.append(s)
            return [s]
        else:
            match s:
                case Assign([Name(id)], value):
                    # the rco_expr returns a modified expression 
                    # with side effects stored in self.res
                    self.res.append(Assign([Name(id)], self.rco_expr(value)))
                case Expr(value):
                    self.res.append(Expr(self.rco_expr(value)))
                # case Call(Name('print'), [arg]):
                #     new_id = generate_name(8)
                #     self.res.append(Assign([Name(new_id)], self.rco_expr(arg)))
                #     self.res.append(Call(Name('print'), [new_id]))
                case _:
                    raise Exception('error in rco_stmt, unexpected ' + repr(s))

    def remove_complex_operands(self, e):
        match e:
            case Module(body):
                for s in body:
                    self.rco_stmt(s)
                return Module(self.res, [])

def rco_Lvar(p):
    return RcoLvar().remove_complex_operands(p)

# select instructions

class Asm:
    __match_args__ = ('opcode', 'operands')
    def __init__(self, opcode, operands=None):
        self.opcode = opcode
        self.operands = operands if operands is not None else []

    def __str__(self):
        return f"{self.opcode} {', '.join(map(str, self.operands))}"
    

def unwrap_atom(c):
    match c:
        case Constant(n):
            return n
        case Name(id):
            return id
        case _:
            raise Exception('error in unwrap_constant, unexpected ' + repr(c))

def select_stmt(stmt) -> list[Asm]:
    match stmt:
        case Assign([id], value):
            match value:
                case Constant(n):
                    return [Asm('movq', [n, id])]
                case Name(id2):
                    return [Asm('movq', [Name(id2), id])]
                case BinOp(left, Add(), right):
                    return [
                        Asm('movq', [(left), '%rax']),
                        Asm('addq', [(right), '%rax']),
                        Asm('movq', ['%rax', id])
                    ]
                case UnaryOp(USub(), operand):
                    return [
                        Asm('movq', [(operand), '%rax']),
                        Asm('negq', ['%rax']),
                        Asm('movq', ['%rax', id])
                    ]
                case Call(Name('input_int'), []):
                    return [
                        Asm('callq', ['input_int']),
                        Asm('movq', ['%rax', id])
                    ]
                case _:
                    raise Exception('error in select_stmt, unexpected ' + dump(stmt))
        case Expr(Call(Name('print'), [arg])):
            return [
                Asm('movq', [(arg), '%rdi']),
                Asm('callq', ['print'])
            ]
        case _:
            raise Exception('error in select_stmt, unexpected ' + repr(stmt))
        
def select_Lvar(p):
    from functools import reduce
    from operator import concat
    match p:
        case Module(body):
            return list( reduce(concat, [select_stmt(s) for s in body]))
        
def pretty_print(p):
    for stmt in (p):
        print(stmt)

# Assign homes

rbps = {}
rbp_inc = -8
def arg(a):
    global rbp_inc
    match a:
        case Name(id):
            if id in rbps:
                return rbps[id]
            else:
                rbps[id] = str(rbp_inc) + '(%rbp)'
                rbp_inc -= 8
                return rbps[id]
        case Constant(n):
            return '$' + str(n)
        case _:
            return a

def mod_asm(asm):
    match asm:
        case Asm(x, [a, b]):
            return Asm(x, [arg(a), arg(b)])
        case Asm(x, [a]):
            return Asm(x, [arg(a)])
        case Asm(x, []):
            return Asm(x, [])

def assign_homes(p):
    global rbps
    global rbp_inc
    rbps = {}
    rbp_inc = -8
    res = []
    for stmt in p:
        res.append(mod_asm(stmt))
    return res


# patch instructions
def is_address_rbp(x):
    return str(x)[-6:] == '(%rbp)'

def patch_instructions(p):
    res = []
    for stmt in p:
        match stmt:
            case Asm('movq', [a, b]):
                if is_address_rbp(a) and is_address_rbp(b):
                    res.append(Asm('movq', [a, '%rax']))
                    res.append(Asm('movq', ['%rax', b]))
                else:
                    res.append(stmt)
            case _:
                res.append(stmt)
    return res


# prelude and conclusion
def prelude():
    return [
        Asm('pushq', ['%rbp']),
        Asm('movq', ['%rsp', '%rbp'])
    ]

def compile_Lvar(source: str) -> str:
    ast0 = parse(source)
    rco_ast = rco_Lvar(ast0)
    mir = select_Lvar(rco_ast)
    asm0 = assign_homes(mir)
    asm1 = patch_instructions(asm0)
    asm2 = prelude() + asm1
    header = '.globl main\nmain:\n'
    return header + '\n'.join(map(str, asm2))

print(compile_Lvar('x = input_int() + 1\ny = -x + 1 + 100\nprint(y+x)'))