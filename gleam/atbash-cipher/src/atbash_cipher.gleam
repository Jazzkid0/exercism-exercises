import gleam/list
import gleam/string

pub fn encode(phrase: String) -> String {
  phrase
  |> string.lowercase
  |> to_encoded_codepoints
  |> list.sized_chunk(5)
  |> list.map(string.from_utf_codepoints)
  |> string.join(" ")
}

pub fn decode(phrase: String) -> String {
  phrase
  |> to_encoded_codepoints
  |> string.from_utf_codepoints
}

fn to_encoded_codepoints(str: String) -> List(UtfCodepoint) {
  use int <- list.filter_map(
    str
    |> string.to_utf_codepoints
    |> list.map(string.utf_codepoint_to_int),
  )
  case int {
    x if x >= 97 && x <= 122 -> 219 - x |> string.utf_codepoint
    x if x >= 48 && x <= 58 -> x |> string.utf_codepoint
    _ -> Error(Nil)
  }
}
