pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    41 -> "So close"
    43 -> "So close"
    n if n < 41 -> "Too low"
    n if n > 43 -> "Too high"
    n if n < 1 || n > 100 -> "Invalid guess"
    _ -> "Somehow not an int. Unreachable?"
  }
}
