import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  {
    use acc, points, values <- dict.fold(legacy, [])
    acc |> list.append({
      use letter <- list.map(values)
      #(string.lowercase(letter), points)
    })
  }
  |> dict.from_list
}
