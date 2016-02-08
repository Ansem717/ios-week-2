//: Playground - noun: a place where people can play

import UIKit


func reverseArray(array: [AnyObject]) -> [AnyObject]
{
    var newArr = [AnyObject]()
    for (index, item) in array.enumerate() {
        let currEle = array[array.endIndex - index - 1]
        newArr.append(currEle)
    }
    return newArr
}

reverseArray([1,2,3,4,5,"Howdy",7,8,9,10])
reverseArray([100,"Alpha","Bet"])
reverseArray(["","Middle",""])
reverseArray([false,true,""])
