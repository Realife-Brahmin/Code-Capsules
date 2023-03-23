function canSum(targetSum, arr, startIdx = 0, numItrs = 0, memo = {}){
    // console.log(targetSum, arr.slice(startIdx));
    if (numItrs === 0){ //sort the array
        arr.sort();
    } 
    const key = targetSum + ',' + startIdx;
    if (key in memo) return memo[key];
    else if (startIdx >= arr.length) return false;    
    else if (targetSum < arr[startIdx]) return false;
    else if (targetSum === arr[startIdx]) return true;
    (memo[key] = 
    canSum(targetSum, arr, startIdx+1, numItrs+1, memo) || 
    canSum(targetSum - arr[startIdx], arr, startIdx, numItrs+2, memo));
    return memo[key];
}   

console.log(canSum(7, [5, 3, 4, 7])); //true
console.log(canSum(8, [2, 4, 4, 5])); //true
console.log(canSum(1, [2])); //false
console.log(canSum(17, [8, 3, 4, 5, 2, 9])); //true
console.log(canSum(17, [1])); //true


//without memoization, the last computation is very slow.