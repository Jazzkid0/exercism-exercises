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

pub fn roll(game: Game, knocked_pins: Int) -> Result(Game, Error) {
  // find a way to async build frame by frame
  // it's annoying af to check the state of a frame
  let current_frame = case list.last(game.frames) {
    Ok(frame) -> frame
    Error(_) -> Frame([], [])
  }
  case list.length(game.frames), list.length(current_frame.rolls) {
    f, r if f >= 10 || r >= 3 -> GameComplete
    _, _ -> todo
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  todo
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

