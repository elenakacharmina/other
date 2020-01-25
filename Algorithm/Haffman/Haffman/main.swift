//По данной непустой строке s длины не более 10000, состоящей из строчных букв латинского алфавита, постройте оптимальный беспрефиксный код. В первой строке выведите количество различных букв k, встречающихся в строке, и размер получившейся закодированной строки. В следующих k строках запишите коды букв в формате "letter: code". В последней строке выведите закодированную строку.


struct CharAndFrequence {
    var char: String
    var frequence: Int
}


func huffman(array: [CharAndFrequence], dict: inout [Character: String]) {
    let arrayChar = Array(array[0].char)
    for i in arrayChar {
        if dict[i] == nil {
            dict[i] = "0"
        } else {
            dict[i] = "0" + dict[i]!
        }
    }
    if array.count > 1 {
        let arrayChar1 = Array(array[1].char)
        for i in arrayChar1 {
            if dict[i] == nil {
                dict[i] = "1"
            } else {
                dict[i] = "1" + dict[i]!
            }
        }

        var copyArray = array
        copyArray.append(CharAndFrequence(char: copyArray[0].char + copyArray[1].char,
                                          frequence: copyArray[0].frequence + copyArray[1].frequence))
        copyArray.remove(at: array.startIndex)
        copyArray.remove(at: array.startIndex)
        
        if copyArray.count > 1 {
            copyArray.sort(by: {$0.frequence < $1.frequence})
            huffman(array: copyArray, dict: &dict)
        }
    }
    
}

let input = readLine()
if let input = input {
    let inputNumberCharacters = Array(input)

    
    var array = [CharAndFrequence]()
    
    for i in inputNumberCharacters {
        var have = false
        for j in 0..<array.count where have == false {
            if String(i) == array[j].char {
                have = true
                array[j].frequence += 1
            }
        }
        if have == false {
            array.append(CharAndFrequence(char: String(i), frequence: 1))
        }
    }
    array.sort(by: {$0.frequence < $1.frequence})
    
    var dict = [Character: String]()
    huffman(array: array, dict: &dict)
    print(dict.count, terminator: " ")
    
    var resultStr = ""
    for i in inputNumberCharacters {
        resultStr += dict[i]!
    }
    
    print(resultStr.count)
    
    for i in dict {
        print("\(i.key): \(i.value)")
    }
    print(resultStr)
}


