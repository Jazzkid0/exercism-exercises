import gleam/list

pub fn rows(n: Int) -> List(List(Int)) {
  triangle(n, [], [])
}

fn triangle(n: Int, prev_row: List(Int), acc: List(List(Int))) -> List(List(Int)) {
  case n {
    a if a <= 0 -> case acc {
      [] -> []
      _ -> acc
    }
    _ -> {
      let row = do_row(prev_row, 0, [])
      triangle(n - 1, row, list.append(acc, [row]))
    }
  }
}

fn do_row(row: List(Int), last: Int, acc: List(Int)) -> List(Int) {
  case row {
    [] -> list.append(acc, [1])
    [1] -> do_row([], 1, list.append(acc, [1 + last]))
    [1, ..tail] -> do_row(tail, 1, list.append(acc, [1]))
    [head, ..tail] -> do_row(tail, head, list.append(acc, [head + last]))
  }
}
