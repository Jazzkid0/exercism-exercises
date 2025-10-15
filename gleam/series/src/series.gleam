import gleam/list
import gleam/string

// outputs all contiguous substrings of a given size, in the order that they appear.
pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  let len = string.length(input)
  case input, size {
    _, 0 -> Error(SliceLengthZero)
    _, s if s < 0 -> Error(SliceLengthNegative)
    "", _ -> Error(EmptySeries)
    _, s if s > len -> Error(SliceLengthTooLarge)
    in, s -> {
      list.range(0, len - s)
        |> list.map(fn(i) { string.slice(in, i, s) })
        |> Ok
    }
  }
}

pub type Error {
  SliceLengthZero
  SliceLengthNegative
  SliceLengthTooLarge
  EmptySeries
}
