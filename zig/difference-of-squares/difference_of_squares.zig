pub fn squareOfSum(number: usize) usize {
    var i: u64 = 0;
    var res: u64 = 0;
    while (i <= number) {
        res += i;
        i += 1;
    }
    return (res * res);
}

pub fn sumOfSquares(number: usize) usize {
    var i: u64 = 0;
    var res: u64 = 0;
    while (i <= number) {
        res += (i * i);
        i += 1;
    }
    return res;
}

pub fn differenceOfSquares(number: usize) usize {
    return squareOfSum(number) - sumOfSquares(number);
}
