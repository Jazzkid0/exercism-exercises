import gleam/string
import gleam/bool

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  use <- bool.guard(string.length(strand1) != string.length(strand2), Error(Nil))
  do_distance(string.to_graphemes(strand1), string.to_graphemes(strand2), 0) |> Ok
}

fn do_distance(s1: List(String), s2: List(String), acc: Int) -> Int {
  case s1, s2 {
    [], [] -> acc
    [a, ..r1], [b, ..r2] if a == b -> do_distance(r1, r2, acc)
    [a, ..r1], [b, ..r2] if a != b -> do_distance(r1, r2, acc + 1)
    _, _ -> panic as "unmatched lengths"
  }
}

