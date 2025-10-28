fn count_neighbors(garden: &[&str], row: isize, col: isize, neighbor_idx: usize) -> usize {
    let directions = [
        (-1, 0),    // N
        (-1, 1),    // NE
        (0, 1),     // E
        (1, 1),     // SE
        (1, 0),     // S
        (1, -1),    // SW
        (0, -1),    // W
        (-1, -1),   // NW
    ];

    match directions.get(neighbor_idx) {
        None => 0,
        Some(&(dr, dc)) => {
            let new_row = row + dr;
            let new_col = col + dc;

            (match
                new_row >= 0
                && new_row < garden.len() as isize
                && new_col >= 0
                && new_col < garden[0].len() as isize 
                && garden[new_row as usize].as_bytes()[new_col as usize] == b'*'
            {
                true => 1,
                false => 0,
            })
            + count_neighbors(garden, row, col, neighbor_idx + 1)
        }
    }

}

pub fn annotate(garden: &[&str]) -> Vec<String> {
    garden
        .iter()
        .enumerate()
        .map(|(row_idx, row)| {
            row
                .chars()
                .enumerate()
                .map(|(col_idx, cell)| match cell {
                    '*' => '*',
                    _ => match count_neighbors(garden, row_idx as isize, col_idx as isize, 0) {
                        0 => ' ',
                        n => std::char::from_digit(n as u32, 10).unwrap(),
                    },
                })
                .collect()
        })
        .collect()
}

pub fn display(garden: &[&str]) -> Vec<String> {
    garden
        .iter()
        .map(|row| row.to_string())
        .collect()
}
