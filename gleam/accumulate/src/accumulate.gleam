import gleam/list

pub fn accumulate(list: List(a), fun: fn(a) -> b) -> List(b) {
  do_accumulate(list, fun, [])
}

fn do_accumulate(list: List(a), fun: fn(a) -> b, acc: List(b)) -> List(b) {
  case list {
    [] -> acc
    [head, ..tail] -> do_accumulate(tail, fun, list.append(acc, [fun(head)]))
  }
}
