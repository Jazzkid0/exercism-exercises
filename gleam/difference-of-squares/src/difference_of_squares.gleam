import gleam/iterator

pub fn square_of_sum(n: Int) -> Int {
  let x = square_of_sum_accumulator(n, 1, 0)
  x * x
}

fn square_of_sum_accumulator(n: Int, inc: Int, acc: Int) -> Int {
  case inc > n {
    True -> acc
    False -> square_of_sum_accumulator(n, inc + 1, acc + inc)
  }
}

pub fn sum_of_squares(n: Int) -> Int {
  iterator.range(0, n)
  |> iterator.fold(0, fn(acc, x) {acc + {x * x}})
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
