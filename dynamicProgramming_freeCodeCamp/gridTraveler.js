const gridTraveler = (rows, cols, memo = {}) => {
    const key = rows + ',' + cols;
    if (key in memo) return memo[key];    
    if (rows === 1 && cols === 1) return 1;
    if (rows === 0 || cols === 0) return 0;
    memo[key] =  gridTraveler(rows-1, cols, memo) + gridTraveler(rows, cols-1, memo);
    return memo[key];
}   

console.log(gridTraveler(1, 1));
console.log(gridTraveler(2, 3));
console.log(gridTraveler(3, 2));
console.log(gridTraveler(3, 3));
console.log(gridTraveler(18, 18));