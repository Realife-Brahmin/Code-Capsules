arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5];
arr.push(7);
arr3 = Array();
arr3.push(8);
console.log(arr3)
// arr2 = arr.sort();
memo = {}
key = 'abc' + 1;
memo[key] = 12;
if (Object.keys(memo).length == 0) arr.sort();

console.log(arr); // Output: [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]
// console.log(arr2);