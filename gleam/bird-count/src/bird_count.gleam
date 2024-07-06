import gleam/list

pub fn today(days: List(Int)) -> Int {
  case list.first(days) {
    Ok(i) -> i
    Error(_) -> 0
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [n, ..rest] -> [n+1, ..rest]
    _ -> [1]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  list.contains(days, 0)
}

pub fn total(days: List(Int)) -> Int {
  case list.reduce(days, fn(a, x) {a + x}) {
    Ok(l) -> l
    Error(_) -> 0
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  list.filter(days, fn(i) {i >= 5})
  |> list.length
}
