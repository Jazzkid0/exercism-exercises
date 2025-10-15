import gleam/list
import gleam/string

pub fn reverse(value: String) -> String {
  value
  |> string.to_utf_codepoints
  |> list.reverse
  |> string.from_utf_codepoints
}
