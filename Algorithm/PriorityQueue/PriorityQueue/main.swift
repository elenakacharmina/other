import Foundation

func insert(array: inout [Int], element: Int) {
    array.append(element)
    var index = array.count
    if array.count > 1 {
        siftUp(array: &array, index: &index)
    }
}

func siftUp(array: inout [Int], index: inout Int) {
    while index > 1 && array[index - 1] > array[index / 2 - 1] {
        let temp = array[index - 1]
        array[index - 1] = array[index / 2 - 1]
        array[index / 2 - 1] = temp
        index /= 2
    }
}

func siftDown(array: inout [Int]) {
    var index = 1
    while index * 2 < array.count && (array[index - 1] < array[index * 2 - 1] || array[index - 1] < array[index * 2]) {
        if array[index * 2 - 1] > array[index * 2] {
            let temp = array[index - 1]
            array[index - 1] = array[index * 2 - 1]
            array[index * 2 - 1] = temp
            index = index * 2
        } else {
            let temp = array[index - 1]
            array[index - 1] = array[index * 2]
            array[index * 2] = temp
            index = index * 2 + 1
        }
        
    }
    if index * 2 == array.count && array[index - 1] < array[index * 2 - 1] {
        let temp = array[index - 1]
        array[index - 1] = array[index * 2 - 1]
        array[index * 2 - 1] = temp
        index = index * 2
    }
    
}

func extractMax(array: inout [Int]){
    print(array[0])
    array[0] = array[array.count - 1]
    array.remove(at: array.endIndex - 1)
    if array.count > 1 {
        siftDown(array: &array)
    }
}


let input = readLine()
if let input = input {
    let inputNumberCharacters = input.split(separator: " ")
    let numbers = inputNumberCharacters.map { Int(String($0))! }
    var array = [Int]()
    for _ in 0..<numbers[0] {
        let input2 = readLine()
        if let input2 = input2 {
            let inputNumberCharacters2 = input2.split(separator: " ")
            if inputNumberCharacters2.count > 1 {
                let number = Int(inputNumberCharacters2[1])
                insert(array: &array, element: number!)
            } else {
                extractMax(array: &array)
            }
        }
    }
}


