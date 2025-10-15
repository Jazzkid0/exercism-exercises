import gleam/bool

pub type Position {
  Position(row: Int, column: Int)
}

pub type Error {
  RowTooSmall
  RowTooLarge
  ColumnTooSmall
  ColumnTooLarge
}

pub fn create(queen: Position) -> Result(Nil, Error) {
  use <- bool.guard(queen.row < 0, Error(RowTooSmall))
  use <- bool.guard(queen.row > 7, Error(RowTooLarge))
  use <- bool.guard(queen.column < 0, Error(ColumnTooSmall))
  use <- bool.guard(queen.column > 7, Error(ColumnTooLarge))
  Ok(Nil)
}

pub fn can_attack(
  black_queen black_queen: Position,
  white_queen white_queen: Position,
) -> Bool {
  let #(Position(x1, y1), Position(x2, y2)) = #(black_queen, white_queen)
  x1 == x2 || y1 == y2 || y1 - x1 == y2 - x2 || y1 + x1 == y2 + x2
}
