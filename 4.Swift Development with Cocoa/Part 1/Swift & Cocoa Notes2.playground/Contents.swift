//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

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

/*
var sNumber = 15

switch sNumber{
case 0...10:
    println("between 0~10")
case 11...20:
    println("between 11~20")
default:
    println("something else")
}
*/

func firstFunction(){
    println("Hello")
}
firstFunction()

func secondFunction(fristvalue:Int,secondvalue:Int)->Int{
    return fristvalue + secondvalue
}
secondFunction(1, 2)

func thirdFunction(firstValue:Int,secondValue:Int) ->(double:Int,quad:Int){
    return (firstValue*2,secondValue*4)
}
thirdFunction(2, 4)

func multiplyNumbers(#firstNumber: Int,#multiplier:Int)->Int{
    return firstNumber * multiplier
}
multiplyNumbers(firstNumber: 2, multiplier: 3)

func sumNumbers(numbers: Int...)->Int{
    var total = 0
    for number in numbers{
        total += number
    }
    return total
}
sumNumbers(2,3,4,5)

func createIncrementor(incrementAmount:Int)-> () ->Int{
    var amount = 0
    func incrementor()->Int{
        amount += incrementAmount
        return amount
    }
    return incrementor
}

var incrementByTen = createIncrementor(10)
incrementByTen()
incrementByTen()

var incrementByFifteen = createIncrementor(15)
incrementByFifteen()

//clourse
var sortingInline = [2,5,98,2,13]
sort(&sortingInline)
sortingInline

var numbers = [2,1,56,32,120,13]
var numbersSorted = sorted(numbers,{(n1:Int,n2:Int)-> Bool in
  return n1>n2
})

var comparator = {(a:Int,b:Int)in a < b}
comparator(1,2)





















