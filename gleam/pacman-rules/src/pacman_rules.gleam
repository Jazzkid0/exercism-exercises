pub fn eat_ghost(power_pellet_active: Bool, touching_ghost: Bool) -> Bool {
  case power_pellet_active, touching_ghost {
    True, True -> True
    _, _ -> False
  }
}

pub fn score(touching_power_pellet: Bool, touching_dot: Bool) -> Bool {
  case touching_power_pellet, touching_dot {
    False, False -> False
    _, _ -> True
  }
}

pub fn lose(power_pellet_active: Bool, touching_ghost: Bool) -> Bool {
  case power_pellet_active, touching_ghost {
    False, True -> True
    _, _ -> False
  }
}

pub fn win(
  has_eaten_all_dots: Bool,
  power_pellet_active: Bool,
  touching_ghost: Bool,
) -> Bool {
  case has_eaten_all_dots, lose(power_pellet_active, touching_ghost) {
    True, False -> True
    _, _ -> False
  }
}
