func search(array: [Int], num: Int, low: Int, high: Int) -> Int? {
    if high - low <= 1 {
        if num == array[low] {
            return low
        } else if num == array[high] {
            return high
        } else {
            return nil
        }
    } else {
        if num > array[(low + high) / 2] {
            return search(array: array, num: num, low: (low + high) / 2, high: high)
        } else {
            return search(array: array, num: num, low: low, high: (low + high) / 2)
        }
    }
}



func sortAndCount(_ array : [Int]) -> ([Int], Int) {
    guard array.count > 1 else {
        return (array, 0)
    }

    let middleIndex = array.count / 2
    let (leftArray, leftCount)  = sortAndCount(Array(array[0..<middleIndex]))
    let (rightArray, rightCount) = sortAndCount(Array(array[middleIndex..<array.count]))
    let (finalArray, splitCount) = mergeAndCountSplitInversation(leftArray, rightArray)
    return (finalArray, leftCount + rightCount + splitCount)
}

func mergeAndCountSplitInversation(_ leftPile: [Int], _ rightPile: [Int]) -> ([Int], Int) {
    var leftIndex = 0
    var rightIndex = 0
    var orderedPile = [Int]()
    var inversationCount = 0

    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] <= rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
            inversationCount = inversationCount + leftPile.count - leftIndex
        }
    }

    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }

    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }

    return (orderedPile, inversationCount)
}

func mergeSort(array: inout [Int], count: inout UInt64) {
    if array.count > 1 {
        let mid = array.count / 2
        var array1: [Int] = Array(array[0...mid - 1])
        var array2 = Array(array[mid...array.count - 1])
        mergeSort(array: &array1, count: &count)
        mergeSort(array: &array2, count: &count)
        //var arrayResult = array
        var k1 = 0
        var k2 = 0
        for i in 0..<array.count {
            if array1[k1] <= array2[k2] {
                array[i] = array1[k1]
                k1 += 1
                if k1 == array1.count {
                    for j in 1...array2.count - k2 {
                        array[i + j] = array2[k2]
                        k2 += 1
                    }
                    break
                }
            } else {
                array[i] = array2[k2]
                k2 += 1
                count += UInt64(array1.count - k1)
                if k2 == array2.count {
                    array[i + 1] = array1[k1]
                    break
                }
            }
        }
    }
    
}

func inverstionCountNaive (_ array :[Int]) -> Int {
    var inverstionCount = 0
    for i in 0..<array.count-1 {
        for j in i+1..<array.count {
            if array[i] > array[j] {
              inverstionCount += 1
            }
        }
    }

    return inverstionCount
}


let input = readLine()
if let input = input {
    let inputNumberCharacters = input.split(separator: " ")
    let numbers = inputNumberCharacters.map { Int(String($0))! }
    var array = [Int](repeating: 0, count: numbers[0])
    let input2 = readLine()
    if let input2 = input2 {
        let inputNumberCharacters2 = input2.split(separator: " ")
        let numbers2 = inputNumberCharacters2.map { Int(String($0))! }
        for i in 0..<numbers[0] {
            array[i] = numbers2[i]
        }
              }
}


