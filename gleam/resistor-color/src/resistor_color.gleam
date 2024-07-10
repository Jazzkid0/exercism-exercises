import gleam/list

pub type Color {
  Black
  Brown
  Red
  Orange
  Yellow
  Green
  Blue
  Violet
  Grey
  White
}

pub fn code(color: Color) -> Int {
  case index_accumulator(colors(), color, 0) {
    Ok(n) -> n
    Error(_) -> 0 // this should never happen, but fortunately the specification doesn't account for any bad input
  }
}

fn index_accumulator(list, item, acc) {
  case list {
    [] -> Error(Nil)
    [head, ..tail] -> case head == item {
      True -> Ok(acc)
      False -> index_accumulator(tail, item, acc + 1)
    }
  }
}

pub fn colors() -> List(Color) {
  [
    Black,
    Brown,
    Red,
    Orange,
    Yellow,
    Green,
    Blue,
    Violet,
    Grey,
    White,
  ]
}
