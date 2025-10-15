import gleam/string
import gleam/list

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  use candidate <- list.filter(candidates)
  candidate |> string.lowercase != word |> string.lowercase &&
  candidate |> string.length == word |> string.length &&
  candidate |> normalise == word |> normalise
}

fn normalise(str: String) -> List(String) {
  str |> string.lowercase |> string.to_graphemes |> list.sort(string.compare)
}
