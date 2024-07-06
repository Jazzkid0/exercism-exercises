pub type TreasureChest(treasure) {
  TreasureChest(password: String, treasure)
}

pub type UnlockResult (treasure) {
  Unlocked(treasure)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest {
    TreasureChest(pass, treasure) if pass == password -> Unlocked(treasure)
    _ -> WrongPassword
  }
}

