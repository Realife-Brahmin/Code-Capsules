const fibDynamic = (n, memo = {}) => {
    if (n in memo) return memo[n];
    if (n <= 2) return 1;
    memo[n] = fibDynamic(n-1, memo) + fibDynamic(n-2, memo);
    return memo[n];
}

const fibRecursive = (n) => {
    if (n <= 2) return 1;
    return fibRecursive(n-1) + fibRecursive(n-2);
}

// console.log(fib(6));
// console.log(fib(7));
// console.log(fib(8));

console.log(fibDynamic(50));

console.log(fibRecursive(50));
