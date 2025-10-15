// x^2 + y^2 = z^2

pub fn score(x: Float, y: Float) -> Int {
  case x *. x +. y *. y {
    z if z <=. 1.0 -> 10
    z if z <=. 25.0 -> 5
    z if z <=. 100.0 -> 1
    _ -> 0
  }
}
