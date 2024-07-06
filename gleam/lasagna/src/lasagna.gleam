// Please define the expected_minutes_in_oven function
pub fn expected_minutes_in_oven() -> Int {
    40
}

// Please define the remaining_minutes_in_oven function
pub fn remaining_minutes_in_oven(minutes_passed: Int) -> Int {
    40 - minutes_passed
}

// Please define the preparation_time_in_minutes function
pub fn preparation_time_in_minutes(layer_count: Int) -> Int {
    layer_count * 2
}

// Please define the total_time_in_minutes function
pub fn total_time_in_minutes(layer_count: Int, minutes_passed: Int) -> Int {
    preparation_time_in_minutes(layer_count) + minutes_passed
}

// Please define the alarm function
pub fn alarm() -> String {
    "Ding!"
}
