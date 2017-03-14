//: Playground - noun: a place where people can play

import UIKit

var str = "abcdefg"

func reverseString(_ s: String, _ k: Int) -> String {
    var chars = s.characters
    var result = ""
    while k <= chars.count {
        var kString = [Character]()
        for _ in 1...k {
            kString.append(chars.popFirst()!)
        }
        result += String(kString.reversed())
        
        for _ in 1...k {
            if let popChar = chars.popFirst() {
                result.append(popChar)
            }
        }
    }
    result += String(chars.reversed())
    return result
}

reverseString(str,2)