

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

let input = readLine()
if let input = input {
    let inputNumberCharacters = input.split(separator: " ")
    let numbers = inputNumberCharacters.map { Int(String($0))! }
    let n = numbers[0]
    let m = numbers[1]
    var arrayLeft = [Int](repeating: 0, count: n)
    var arrayRight = [Int](repeating: 0, count: n)
    var arrayPoint = [Int](repeating: 0, count: m)
    for i in 0..<n {
        let input2 = readLine()
        if let input2 = input2 {
            let inputNumberCharacters2 = input2.split(separator: " ")
            let numbers2 = inputNumberCharacters2.map { Int(String($0))! }
            arrayLeft[i] = numbers2[0]
            arrayRight[i] = numbers2[1]
        }
    }
    let input2 = readLine()
    if let input2 = input2 {
        let inputNumberCharacters2 = input2.split(separator: " ")
        let numbers2 = inputNumberCharacters2.map { Int(String($0))! }
        for i in 0..<m {
            arrayPoint[i] = numbers2[i]
        }
    }
    quickSort(array: &arrayLeft, b: 0, e: arrayLeft.count - 1)
    quickSort(array: &arrayRight, b: 0, e: arrayRight.count - 1)
    for i in arrayPoint {
        print(search(array: arrayLeft, num: i, low: 0, high: arrayLeft.count - 1))
        print(searchRight(array: arrayRight, num: i, low: 0, high: arrayRight.count - 1), terminator: " ")
        
    }
}



