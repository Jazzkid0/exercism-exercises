import gleam/option.{type Option}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  option.unwrap(player.name, "Mighty Magician")
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health {
    0 if player.level < 10 -> option.Some(Player(..player, health: 100))
    0 if player.level >= 10 -> option.Some(Player(..player, health: 100, mana: option.Some(100)))
    _ -> option.None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    option.Some(n) if n >= cost -> #(Player(..player, mana: option.Some(n - cost)), cost * 2)
    option.Some(n) if n < cost -> #(player, 0)
    option.None if cost >= player.health -> #(Player(..player, health: 0), 0)
    option.None if cost < player.health -> #(Player(..player, health: player.health - cost), 0)
    _ -> #(player, 0)
  }
}
