import gleam/bool
import gleam/int
import gleam/list

pub fn scores(high_scores: List(Int)) -> List(Int) {
  high_scores
}

pub fn latest(high_scores: List(Int)) -> Result(Int, Nil) {
  high_scores |> list.last
}

pub fn personal_best(high_scores: List(Int)) -> Result(Int, Nil) {
  use <- bool.guard(high_scores == [], Error(Nil))
  high_scores
  |> list.sort(int.compare)
  |> list.reverse
  |> list.first
}

pub fn personal_top_three(high_scores: List(Int)) -> List(Int) {
  high_scores
  |> list.sort(int.compare)
  |> list.drop(list.length(high_scores) - 3)
  |> list.reverse
}
