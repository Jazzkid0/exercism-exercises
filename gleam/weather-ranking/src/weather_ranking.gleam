import gleam/order.{type Order}
import gleam/float
import gleam/list

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  {f -. 32.0} /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  let l = case left {
    Fahrenheit(val) -> fahrenheit_to_celsius(val)
    Celsius(val) -> val
  }
  let r = case right {
    Fahrenheit(val) -> fahrenheit_to_celsius(val)
    Celsius(val) -> val
  }
  float.compare(l, r)
}

pub fn compare_city_by_temperature(left: City, right: City) -> Order {
  compare_temperature(left.temperature, right.temperature)
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  list.sort(cities, by: compare_city_by_temperature)
}
