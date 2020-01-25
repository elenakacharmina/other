

func search(array: [Int], num: Int, low: Int, high: Int) -> Int {
    if high - low <= 1 {
        if num >= array[high] {
            return high + 1
        } else if num >= array[low]{
            return low + 1
        } else {
            return low
        }
    } else {
        if num >= array[(low + high) / 2] {
            return search(array: array, num: num, low: (low + high) / 2, high: high)
        } else {
            return search(array: array, num: num, low: low, high: (low + high) / 2)
        }
    }
}

func searchRight(array: [Int], num: Int, low: Int, high: Int) -> Int {
    if high - low <= 1 {
        if num > array[high] {
            return high + 1
        } else if num > array[low]{
            return low + 1
        } else {
            return low
        }
    } else {
        if num <= array[(low + high) / 2] {
            return searchRight(array: array, num: num, low: low, high: (low + high) / 2)
            
        } else {
            return searchRight(array: array, num: num, low: (low + high) / 2, high: high)
        }
    }
}





func quickSort(array: inout [Int], b: Int, e: Int) {
    var l = b
    var r = e
    let mid = array[(l + r) / 2]
    while l <= r {
        while array[l] < mid {
            l += 1
        }
        while array[r] > mid {
            r -= 1
        }
        if l <= r {
            let temp = array[l]
            array[l] = array[r]
            array[r] = temp
            l += 1
            r -= 1
        }
    }
    if b < r {
        quickSort(array: &array, b: b, e: r)
    }
    if e > l {
        quickSort(array: &array, b: l, e: e)
    }
}

func countSort(array: [Int]) -> [Int]{
    var arrayB = [Int](repeating: 0, count: 10)
    for j in 0..<array.count {
        arrayB[array[j] - 1] += 1
    }
    for i in 1...9 {
        arrayB[i] += arrayB[i - 1]
    }
    var newArray = array
    for j in (0...array.count - 1).reversed() {
        newArray[arrayB[array[j] - 1] - 1] = array[j]
        arrayB[array[j] - 1] -= 1
    }
    return newArray
}

let input = readLine()
if let input = input {
    let inputNumberCharacters = input.split(separator: " ")
    let numbers = inputNumberCharacters.map { Int(String($0))! }
    let n = numbers[0]
    let input2 = readLine()
    if let input2 = input2 {
        var array = [Int](repeating: 0, count: n)
        let inputNumberCharacters2 = input2.split(separator: " ")
        let numbers2 = inputNumberCharacters2.map { Int(String($0))! }
        for i in 0..<n {
            array[i] = numbers2[i]
        }
        
        let newArray = countSort(array: array)
        for i in newArray {
            print(i, terminator: " ")
        }
    }
    
}



