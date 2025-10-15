pub fn egg_count(number: Int) -> Int {
  do_count(number, 0)
}

fn do_count(x: Int, acc: Int) {
  case x {
    0 -> acc
    x -> do_count(x / 2, acc + x % 2)
  }
}
