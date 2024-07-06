pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  option_price(pizza, 0)
}

fn option_price(pizza: Pizza, accumulated_price: Int) -> Int {
  case pizza {
    Margherita -> 7 + accumulated_price
    Caprese -> 9 + accumulated_price
    Formaggio -> 10 + accumulated_price
    ExtraSauce(next) -> option_price(next, accumulated_price + 1)
    ExtraToppings(next) -> option_price(next, accumulated_price + 2)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  case order {
    [_, _] -> price_list(order, 0) + 2
    [_] -> price_list(order, 0) + 3
    _ -> price_list(order, 0)
  }
}

fn price_list(order: List(Pizza), accumulated_price: Int) -> Int {
  case order {
    [] -> accumulated_price
    [pizza, ..tail] -> {
      let accumulated_price = accumulated_price + pizza_price(pizza)
      price_list(tail, accumulated_price)
    }
  }
}

