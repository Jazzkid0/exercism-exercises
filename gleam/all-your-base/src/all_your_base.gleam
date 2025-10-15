import gleam/bool
import gleam/list

pub type Error {
  InvalidBase(Int)
  InvalidDigit(Int)
}

pub fn rebase(
  digits digits: List(Int),
  input_base input_base: Int,
  output_base output_base: Int,
) -> Result(List(Int), Error) {
  use <- bool.guard(input_base < 2, Error(InvalidBase(input_base)))
  use <- bool.guard(output_base < 2, Error(InvalidBase(output_base)))
  case digits_to_int(digits, input_base) {
    Error(e) -> Error(e)
    Ok(digits) -> digits |> int_to_digits(output_base) |> Ok
  }
}

fn digits_to_int(digits: List(Int), base: Int) -> Result(Int, Error) {
  use acc, digit, index <- list.index_fold(digits |> list.reverse, Ok(0))
  case acc {
    Error(e) -> Error(e)
    Ok(sum) -> {
      case digit {
        d if d < 0 || d >= base -> Error(InvalidDigit(d))
        _ -> Ok(sum + digit * int_pow(base, index))
      }
    }
  }
}

fn int_to_digits(int: Int, base: Int) -> List(Int) {
  do_int_to_digits(int, base, [])
}

fn do_int_to_digits(int: Int, base: Int, acc: List(Int)) -> List(Int) {
  case int {
    n if n < base -> acc |> list.append([n]) |> list.reverse
    n -> do_int_to_digits(n / base, base, acc |> list.append([n % base]))
  }
}

fn int_pow(base: Int, exp: Int) -> Int {
  int_pow_acc(base, exp, 1)
}

fn int_pow_acc(base: Int, exp: Int, acc: Int) -> Int {
  case exp {
    0 -> acc
    n if n % 2 == 0 -> int_pow_acc(base * base, n / 2, acc)
    _ -> int_pow_acc(base, exp - 1, acc * base)
  }
}
