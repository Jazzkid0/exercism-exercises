import gleam/string
import gleam/int
import gleam/list
import gleam/dict.{type Dict}

pub opaque type Forth {
  Forth(stack: List(Int), vars: Dict(String, List(String)), state: ForthState)
}

pub type ForthError {
  DivisionByZero
  StackUnderflow
  InvalidWord
  UnknownWord
}

pub type ForthState {
  Continue
  DefinitionName
  DefinitionValue(key: String, val: List(String))
}

pub fn new() -> Forth {
  Forth([], dict.new(), Continue)
}

pub fn format_stack(f: Forth) -> String {
  f.stack 
  |> list.reverse()
  |> list.map(int.to_string) 
  |> string.join(" ")
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  prog
  |> string.split(" ")
  |> list.try_fold(f, step)
}

fn step(f: Forth, token: String) -> Result(Forth, ForthError) {
  case f {
    Forth(stack, vars, Continue) -> {
      case dict.get(vars, string.uppercase(token)) {
        Ok(var) -> list.try_fold(var, f, step)
        Error(_) -> {
          let operation_size = case string.uppercase(token) {
            "SWAP"|"OVER"|"+"|"-"|"*"|"/" -> 2
            "DROP"|"DUP"                  -> 1
            _                             -> 0
          }
          let underflow = operation_size > list.length(stack)
          let first_is_zero = list.first(stack) == Ok(0)
          case token, operation_size, int.parse(token) {
             t , n, Error(_) if n <= 0 && t != ":"     -> Error(UnknownWord)
             _ , _, Error(_) if underflow              -> Error(StackUnderflow)
            "/", n, Error(_) if n > 0 && first_is_zero -> Error(DivisionByZero)
            ":", _, Error(_)                           -> Ok(Forth(..f, state: DefinitionName))
             _ , n, Error(_) if n > 0                  -> Ok(Forth(..f, stack: execute(stack, string.uppercase(token))))
             _ , _, Ok(x)                              -> Ok(Forth(..f, stack: [x, ..stack]))
             _ , _, _                                  -> panic as "Unreachable case"
          }
        }
      }
    }
    Forth(_, _, DefinitionName) -> {
      case int.parse(token) {
        Ok(_)    -> Error(InvalidWord)
        Error(_) -> Ok(Forth(..f, state: DefinitionValue(string.uppercase(token), [])))
      }
    }
    Forth(_, vars, DefinitionValue(key, val)) -> {
      case token {
        ";" -> Ok(Forth(..f, vars: dict.insert(f.vars, key, val), state: Continue))
        _   -> case dict.get(vars, token) {
          Ok(var)  -> Ok(Forth(..f, state: DefinitionValue(key, list.append(var, val))))
          Error(_) -> Ok(Forth(..f, state: DefinitionValue(key, [token, ..val])))
        }
      }
    }
  }
}

fn execute(stack: List(Int), operation: String) -> List(Int) {
  case stack, operation {
    [_,    ..tail], "DROP" -> tail
    [x,    ..tail], "DUP"  -> [x,    x, ..tail]
    [x, y, ..tail], "SWAP" -> [y,    x, ..tail]
    [x, y, ..tail], "OVER" -> [y, x, y, ..tail]
    [x, y, ..tail], "+"    -> [y  +  x, ..tail]
    [x, y, ..tail], "-"    -> [y  -  x, ..tail]
    [x, y, ..tail], "*"    -> [y  *  x, ..tail]
    [x, y, ..tail], "/"    -> [y  /  x, ..tail]
    _             , _      -> panic as "Called execute() on an invalid operation"
  }
}
