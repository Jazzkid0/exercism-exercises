import gleam/list
import gleam/result

pub opaque type Frame {
  Frame(rolls: List(Int), bonus: List(Int))
}

pub type Game {
  Game(frames: List(Frame))
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

// list.fold(list(int), Game([]), fn(game, pins) {
//   let assert Ok(new_game) = roll(game, pins)
//   new game})
//   |> score()

// roll() simply takes the current state of the game (a list of frames) and places the input roll in the right frame.
pub fn roll(game: Game, knocked_pins: Int) -> Result(Game, Error) {
  // iterate through the Game (a list of frames) until there's an empty spot, or error.
  // build a new game as you do so?
  // don't worry about bonus for now?
  let frame_count = list.length(game.frames)

  case list.last(list.take(game.frames, frame_count - 1)), frame_count {
    Error(Nil), 0 -> Ok(Game([Frame([knocked_pins], [])]))
    Error(_), _ -> panic
    _, count if count > 10 -> panic
    _, _ -> todo
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  case list.length(game.frames) {
    a if a < 10 -> Error(GameNotComplete)
    // TODO: Check for incomplete last frame
    a if a == 10 -> iter_score(game.frames, 0)
    _ -> panic
  }
}

fn iter_score(frames: List(Frame), score: Int) -> Result(Int, Error) {
  case frames {
    [last] -> Ok(score + frame_score(last))
    [head, ..tail] -> iter_score(tail, frame_score(head))
    _ -> todo
  }
}

fn frame_score(frame: Frame) -> Int {
  result.unwrap(list.first(frame.bonus), 0) + list.fold(frame.rolls, 0, fn(roll, acc) { roll + acc })
}

// TODO: 
// Parse the list of rolls (int) into a list of frames. This happens inside a list.fold(), so do it one roll at a time.
// Evaluate this list of frames for the total score [score].
//
// NOTE:
// Spare is 10 + next throw, Strike is 10 plus next two throws (even if it's two strikes)
// Frame type contains the rolls in the frame, plus the bonus points from following rolls
//
// NOTE:
// below is the function used to test valid games
// it takes a list of ints, no separation in tuples etc
// this means strikes are 1 roll, and final frame can be 3.
// PARSE ITERATIVELY
//
// fn roll_and_check_score(rolls: List(Int), correct_score: Int) {
//   rolls
//   |> list.fold(Game([]), fn(game, pins) {
//     let assert Ok(new_game) = roll(game, pins)
//     new_game
//   })
//   |> score()
//   |> should.equal(Ok(correct_score))
// }

