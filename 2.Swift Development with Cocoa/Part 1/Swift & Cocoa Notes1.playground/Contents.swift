//: Playground - noun: a place where people can play

import UIKit
//variable
var str = "Hello, playground"

var myVariable = 123
let myConstantVariable = 123
myVariable += 5

var aNonOptionalInteger = 42

if aNonOptionalInteger == 42 {
    println("has a value")
} else {
    println("no value")
}
//array
let aTuple = (1,"Yes")
let theNumber = aTuple.0
let theString = aTuple.1
let anotherTuple = (aNumber:1,aString:"Yes")
let tNumber = anotherTuple.aNumber
let tString = anotherTuple.aString
var arrayOfInt = [1,2,3]
arrayOfInt.append(4)
arrayOfInt.insert(0, atIndex: 0)
arrayOfInt.removeAtIndex(4)
arrayOfInt.reverse()
//dictionary
var Martin = [
   "name":"Martin.Tsiu",
    "Age":"23",
    "Job":"Designer"
];
Martin["name"]
//for in
let loopingArray = [1,2,3,4,5]
var loopSum = 0
for number in loopingArray{
    loopSum += number
}
loopSum

var countDown = 5
while countDown > 0 {
    countDown--
    println(countDown)
}

let intswitch = 3

switch intswitch {
case 0:
    println("It's 0")
case 1:
    println("It's 1")
case 2:
    println("It's 2")
default:
    println("something else")
}























