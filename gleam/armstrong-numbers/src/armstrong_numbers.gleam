import gleam/int
import gleam/list

pub fn is_armstrong_number(number: Int) -> Bool {
  let assert Ok(digits) = number |> int.digits(10)
  number == list.fold(digits, 0, fn(acc, i) { acc + int_pow(i, list.length(digits)) })
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
