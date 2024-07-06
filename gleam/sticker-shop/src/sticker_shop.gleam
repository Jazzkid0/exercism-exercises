import gleam/list

pub type Usd
pub type Eur
pub type Jpy

pub opaque type Money(currency) {
  Money(amount: Int)
}

pub fn dollar(amount: Int) -> Money(Usd) {
  let _: Money(Usd) = Money(amount)
}

pub fn euro(amount: Int) -> Money(Eur) {
  let _: Money(Eur) = Money(amount)
}

pub fn yen(amount: Int) -> Money(Jpy) {
  let _: Money(Jpy) = Money(amount)
}

pub fn total(prices: List(Money(currency))) -> Money(currency) {
  list.fold(prices, generic(0), fn(price, acc) {add(acc, price)})
}

fn generic(amount: Int) -> Money(currency) {
  Money(amount)
}

fn add(a: Money(currency), b: Money(currency)) -> Money(currency) {
  Money(a.amount + b.amount)
}
