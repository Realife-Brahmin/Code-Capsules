function numPathways(rows, cols, memo = {}){
    const key = rows + ',' + cols;
    if (key in memo) return memo[key];    
    if (rows === 1 && cols === 1) return 1;
    if (rows === 0 || cols === 0) return 0;
    memo[key] =  numPathways(rows-1, cols, memo) + numPathways(rows, cols-1, memo);
    return memo[key];
}   

console.log(numPathways(1, 1));
console.log(numPathways(2, 3));
console.log(numPathways(3, 2));
console.log(numPathways(3, 3));
console.log(numPathways(18, 18));
//without memoization, the last computation is very slow.