import gleam/list
import gleam/string

pub fn abbreviate(phrase phrase: String) -> String {
  phrase
  |> string.uppercase
  |> string.to_utf_codepoints
  |> list.filter(fn(utf) {
    let cp = string.utf_codepoint_to_int(utf)
    { cp >= 0x41 && cp <= 0x5A } || cp == 0x2D || cp == 0x20
  })
  |> string.from_utf_codepoints
  |> string.replace("-", " ")
  |> string.split(" ")
  |> list.map(fn(word) {word |> string.drop_end(string.length(word) - 1)})
  |> list.fold("", fn(acc, char) {case char { c -> acc <> c }})
}
