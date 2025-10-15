import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  do_to_tree(data, Nil)
}

fn do_to_tree(data: List(Int), acc: Tree) -> Tree {
  case data {
    [] -> acc
    [first, ..rest] -> do_to_tree(rest, acc |> insert_node(first))
  }
}

fn insert_node(tree: Tree, number: Int) -> Tree {
  case tree {
    Nil -> Node(number, Nil, Nil)
    Node(data, left, right) -> {
      case number <= data {
        True -> Node(data, insert_node(left, number), right)
        False -> Node(data, left, insert_node(right, number))
      }
    }
  }
}

fn to_list(tree: Tree) -> List(Int) {
  do_to_list(tree, [])
}

fn do_to_list(tree: Tree, acc: List(Int)) -> List(Int) {
  case tree {
    Nil -> acc
    Node(data, left, right) -> {
      do_to_list(left, [])
      |> list.append([data] |> list.append(do_to_list(right, acc)))
    }
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data |> to_tree |> to_list
}
