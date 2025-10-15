import gleam/int
import gleam/list

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
  case knocked_pins {
    p if p >= 0 && p <= 10 -> apply_roll(game, p)
    _ -> Error(InvalidPinCount)
  }
}

pub fn score(game: Game) -> Result(Int, Error) {
  let Game(frames) = game
  case frames {
    [] -> Error(GameNotComplete)
    _ -> {
      let frame_count = list.length(frames)
      case list.reverse(frames) {
        [last, .._] -> case frame_count, frame_complete(last, 9) {
          10, True -> Ok(score_frames(frames, 0))
          _, _ -> Error(GameNotComplete)
        }
        [] -> Error(GameNotComplete)
      }
    }
  }
}

fn apply_roll(game: Game, pins: Int) -> Result(Game, Error) {
  let Game(frames) = game
  case list.reverse(frames) {
    [] -> Ok(Game([Frame([pins], [])]))
    [last, .._] -> {
      let frame_count = list.length(frames)
      let last_index = frame_count - 1

      case frame_count, frame_complete(last, last_index) {
        10, True -> Error(GameComplete)
        _, _ -> case frame_complete(last, last_index) {
          True -> case frame_count {
            count if count < 10 -> {
              Ok(Game(list.append(frames, [Frame([pins], [])])))
            }
            _ -> Error(GameComplete)
          }
          False -> case last_index {
            index if index < 9 -> append_normal_frame(frames, last, pins)
            _ -> append_final_frame(frames, last, pins)
          }
        }
      }
    }
  }
}

fn append_normal_frame(
  frames: List(Frame),
  last: Frame,
  pins: Int,
) -> Result(Game, Error) {
  let Frame(rolls, bonus) = last
  case rolls {
    [a] if a < 10 && a + pins <= 10 -> {
      Ok(Game(frames |> list.take(list.length(frames) - 1) |> list.append([Frame([a, pins], bonus)])))
    }
    _ -> Error(InvalidPinCount)
  }
}

fn append_final_frame(
  frames: List(Frame),
  last: Frame,
  pins: Int,
) -> Result(Game, Error) {
  let Frame(rolls, bonus) = last
  case rolls {
    [10] -> {
      Ok(Game(frames |> list.take(list.length(frames) - 1) |> list.append([Frame([10, pins], bonus)])))
    }
    [a] if a < 10 && a + pins <= 10 -> {
      Ok(Game(frames |> list.take(list.length(frames) - 1) |> list.append([Frame([a, pins], bonus)])))
    }
    [10, 10] -> {
      Ok(Game(frames |> list.take(list.length(frames) - 1) |> list.append([Frame([10, 10, pins], bonus)])))
    }
    [10, b] if b < 10 && b + pins <= 10 -> {
      Ok(Game(frames |> list.take(list.length(frames) - 1) |> list.append([Frame([10, b, pins], bonus)])))
    }
    [a, b] if a < 10 && a + b == 10 -> {
      Ok(Game(frames |> list.take(list.length(frames) - 1) |> list.append([Frame([a, b, pins], bonus)])))
    }
    _ -> Error(InvalidPinCount)
  }
}

fn frame_complete(frame: Frame, frame_index: Int) -> Bool {
  case frame_index {
    i if i < 9 -> {
      case frame {
        Frame([10], _) -> True
        Frame([_, _], _) -> True
        _ -> False
      }
    }
    _ -> {
      case frame {
        Frame([_, _, _], _) -> True
        Frame([a, b], _) if a + b < 10 -> True
        _ -> False
      }
    }
  }
}

type FrameType {
  Strike
  Spare
  Basic
}

fn score_frames(frames: List(Frame), index: Int) -> Int {
  case frames |> list.drop(index) |> list.first {
    Error(Nil) -> 0
    Ok(Frame(rolls, bonus)) -> case index {
      9 -> int.sum(rolls)
      _ -> case get_frame_type(Frame(rolls, bonus)) {
        Strike -> 10 + int.sum(next_rolls(frames, index, 2)) + score_frames(frames, index + 1)
        Spare -> 10 + int.sum(next_rolls(frames, index, 1)) + score_frames(frames, index + 1)
        Basic -> int.sum(rolls) + score_frames(frames, index + 1)
      }
    }
  }
}

fn next_rolls(frames: List(Frame), index: Int, count: Int) -> List(Int) {
  frames
  |> list.drop(index + 1)
  |> list.map(fn(f) {
    case f {
      Frame(rs, _) -> rs
    }
  })
  |> list.flatten
  |> list.take(count)
}

fn get_frame_type(frame: Frame) {
  case frame {
    Frame([10], _) -> Strike
    Frame([a, b], _) if a + b == 10 -> Spare
    _ -> Basic
  }
}
