import gleam/float
import gleam/int
import gleam/result

pub type Error {
  InvalidSquare
}

pub fn square(square: Int) -> Result(Int, Error) {
  case square {
    s if s > 64 || s <= 0 -> Error(InvalidSquare)
    s -> {
      s - 1
      |> int.to_float
      |> int.power(2, _)
      |> result.unwrap(0.0)
      |> float.truncate
      |> Ok
    }
  }
}

pub fn total() -> Int {
  {
    64.0
    |> float.power(2.0, _)
    |> result.unwrap(0.0)
    |> float.truncate
  }
  - 1
}
