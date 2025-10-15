import gleam/int

pub type Clock {
  Clock(hour: Int, minute: Int)
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  let #(m, dh) = wrap(minute, 60)
  let #(h, _) = { hour + dh } |> wrap(24)
  Clock(h % 24, m % 60)
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  let Clock(hour, minute) = clock
  Clock(
    { hour + { { minute + minutes } / 60 } } % 24,
    { minute + minutes } % 60,
  )
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  let Clock(init_h, init_m) = clock
  let #(m, dh) = init_m - minutes |> wrap(60)
  let #(h, _) = { init_h + dh } |> wrap(24)
  Clock(h, m)
}

pub fn display(clock: Clock) -> String {
  let Clock(hour, minute) = clock
  display_int(hour) <> ":" <> display_int(minute)
}

fn display_int(i: Int) -> String {
  case i {
    x if x < 10 -> "0" <> int.to_string(x)
    x -> int.to_string(x)
  }
}

fn wrap(i: Int, max: Int) -> #(Int, Int) {
  do_wrap(i, max, 0)
}

fn do_wrap(i: Int, max: Int, acc: Int) -> #(Int, Int) {
  case i {
    i if i < 0 -> do_wrap(i + max, max, acc - 1)
    i if i >= max -> do_wrap(i - max, max, acc + 1)
    i -> #(i, acc)
  }
}
