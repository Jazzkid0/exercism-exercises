import gleam/string
import gleam/regex

pub fn hey(remark: String) -> String {
  case is_question(remark), is_loud(remark), is_empty(remark) {
    _, _, True -> "Fine. Be that way!"
    True, True, _ -> "Calm down, I know what I'm doing!"
    _, True, _ -> "Whoa, chill out!"
    True, _, _ -> "Sure."
    _, _, _ -> "Whatever."
  }
}

fn is_empty(s: String) -> Bool {
  string.trim(s) |> string.is_empty()
}

fn is_loud(s: String) -> Bool {
  let assert Ok(lowers) = regex.from_string("[a-z]")
  let assert Ok(uppers) = regex.from_string("[A-Z]")
  !regex.check(lowers, s) && regex.check(uppers, s)
}

fn is_question(s: String) -> Bool {
  case string.trim(s) |> string.last() {
    Ok("?") -> True
    _ -> False
  }
}
