function howSum(targetSum, arr, startIdx = 0, numItrs = 0, combination = Array(), memo = {}){
    console.log(targetSum, arr.slice(startIdx));
    console.log(combination)
    if (numItrs === 0){ //sort the array
        arr.sort();
    } 
    const key = targetSum + ',' + startIdx;
    if (key in memo) return memo[key];
    else if (startIdx >= arr.length){
        memo[key] = [0, -1];
    }     
    else if (targetSum < arr[startIdx]){
        memo[key] = [0, -1];
    } 
    else if (targetSum === arr[startIdx]){
        console.log("Gotcha!")
        console.log(combination);
        console.log(typeof(combination));
        combination.push(arr[startIdx]);
        console.log(combination);
        memo[key] = [1, combination]; 
        console.log(memo[key])
        return memo[key];
    }
    else{
        console.log("All base cases invalid here.")
        combinationCopy = combination;
        combinationCopy.push(arr[startIdx]);
        branch1 = howSum(targetSum, arr, startIdx+1, numItrs+1, combination, memo);
        console.log(branch1)
        branch2 = howSum(targetSum - arr[startIdx], arr, startIdx, numItrs+2, combinationCopy, memo);
        console.log(branch2)
        if (branch1[0] === 1) return branch1;
        else if (branch2[0] === 1) return branch2;
        else memo[key] = [0, combination];
    }
    return memo[key];
}   

console.log(howSum(7, [5, 3, 4, 7])); //true
// console.log(howSum(8, [2, 4, 4, 5])); //true
// console.log(howSum(7, [2, 4])); //false
// console.log(howSum(1, [2])); //false
// console.log(howSum(17, [8, 3, 4, 5, 2, 9])); //true
// console.log(howSum(17, [1])); //true
// console.log(howSum(300, [7, 14])); //false