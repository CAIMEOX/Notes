from ast import *

uop1 = UnaryOp(op=USub(), operand=Constant(8))
uop2 = UnaryOp(op=USub(), operand=Constant(9))
expr1 = BinOp(uop2, Add(), uop1)
stmt1 = Expr(Call(Name('print'), [expr1]))
modu1 = Module([stmt1])

def interp_exp(e):
    match e:
        case BinOp(left, Add(), right):
            return interp_exp(left) + interp_exp(right)
        case BinOp(left, Sub(), right):
            return interp_exp(left) - interp_exp(right)
        case BinOp(left, Mult(), right):
            return interp_exp(left) * interp_exp(right)
        case UnaryOp(USub(), operand):
            return -interp_exp(operand)
        case Constant(value):
            return value
        case Call(Name('input_int'), []):
            return int(input())
        case _:
            raise Exception('Unknown expression')
        
def interp_stmt(s):
    match s:
        case Expr(Call(Name('print'), [arg])):
            print(interp_exp(arg))
        case Expr(value):
            interp_exp(value)

def interp_Lint(p):
    match p:
        case Module(body):
            for stmt in body:
                interp_stmt(stmt)


def pe_neg(r):
    match r:
        case Constant(n):
            return Constant(-n)
        case _:
            return UnaryOp(USub(), r)

def pe_add(r1, r2):
    match (r1, r2):
        case (Constant(n1), Constant(n2)):
            return Constant(n1 + n2)
        case _:
            return BinOp(r1, Add(), r2)

def pe_sub(r1, r2):
    match (r1, r2):
        case (Constant(n1), Constant(n2)):
            return Constant(n1 - n2)
        case _:
            return BinOp(r1, Sub(), r2)
        
def pe_exp(e):
    match e:
        case BinOp(left, Add(), right):
            return pe_add(pe_exp(left), pe_exp(right))
        case BinOp(left, Sub(), right):
            return pe_sub(pe_exp(left), pe_exp(right))
        case UnaryOp(USub(), operand):
            return pe_neg(pe_exp(operand))
        case Constant(value):
            return value
        case Call(Name('input_int'), []):
            return e

def pe_stmt(s):
    match s:
        case Expr(Call(Name('print'), [arg])):
            return Expr(Call(Name('print'), [pe_exp(arg)]))
        case Expr(value):
            return Expr(pe_exp(value))
        
def pe_Pint(p):
    match p:
        case Module(body):
            return Module([pe_stmt(stmt) for stmt in body])
        
interp_Lint(modu1)