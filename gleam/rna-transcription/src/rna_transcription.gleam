import gleam/list
import gleam/string

pub fn to_rna(dna: String) -> Result(String, Nil) {
  dna
  |> string.to_graphemes
  |> do_conversion([])
}

// G-C, C-G, T-A, A-U
fn do_conversion(dna: List(String), acc: List(String)) -> Result(String, Nil) {
  case dna, acc {
    [], acc -> Ok(acc |> list.fold("", string.append))
    [c, ..rest], acc if c == "G" || c == "C" || c == "T" || c == "A" -> do_conversion(rest, acc |> list.append([c |> swap]))
    _, _ -> Error(Nil)
  }
}

fn swap(c: String) -> String {
  case c {
    "G" -> "C"
    "C" -> "G"
    "T" -> "A"
    "A" -> "U"
    _ -> panic as "unreachable if called from do_conversion"
  }
}
