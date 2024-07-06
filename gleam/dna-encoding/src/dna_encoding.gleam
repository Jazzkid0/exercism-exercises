import gleam/list

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0
    Cytosine -> 1
    Guanine -> 2
    Thymine -> 3
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0 -> Ok(Adenine)
    1 -> Ok(Cytosine)
    2 -> Ok(Guanine)
    3 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  dna
  |> list.map(encode_nucleotide)
  |> list.reverse
  |> list.fold(<<>>, fn(acc, nt) {<<nt:2, acc:bits>>})
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  decode_acc(dna, [])
}

fn decode_acc(dna: BitArray, curr: List(Nucleotide)) -> Result(List(Nucleotide), Nil) {
  case dna {
    <<val:2, rest:bits>> -> case decode_nucleotide(val) {
      Ok(nt) -> decode_acc(rest, list.append(curr, [nt]))
      _ -> Error(Nil)
    }
    <<>> -> Ok(curr)
    _ -> Error(Nil)
  }
}
