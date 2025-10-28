#[derive(Debug, PartialEq, Eq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist(first_list: &[i32], second_list: &[i32]) -> Comparison {
    match (first_list, second_list) {
        (a, b) if a == b => Comparison::Equal,
        ([], _) => Comparison::Sublist,
        (_, []) => Comparison::Superlist,
        (a, b) if b.windows(a.len()).any(|window| window == a) => Comparison::Sublist,
        (a, b) if a.windows(b.len()).any(|window| window == b) => Comparison::Superlist,
        _ => Comparison::Unequal,
    }
}
