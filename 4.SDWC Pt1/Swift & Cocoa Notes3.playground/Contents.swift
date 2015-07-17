//: Playground - noun: a place where people can play

import UIKit
//class/object
class Vehicle{
    var color: String?
    var maxspeed = 80
    func description() -> String{
        return "A \(self.color) vehicle"
    }
    func travel(){
        println("Traveling at \(maxspeed) kph")
    }
    
}
//init
class InitAndDeinitExample{
    init(){
        println("I've been created!")
    }
    convenience init(text:String){
        self.init()
        println("I was called with the convenience initializer!")
    }
    deinit{
        println("I'm going away")
    }
}

var example :InitAndDeinitExample?

example = InitAndDeinitExample()
example = nil

example = InitAndDeinitExample(text:"Hello")

//property

class Counter{
    var number:Int = 0
}
let myCounter = Counter()
myCounter.number = 2

class Rectangle{
    var width:Double = 0.0
    var height:Double = 0.0
    var area: Double{
        get{
            return width*height
        }
        set{
            width = sqrt(newValue)
            height = sqrt(newValue)
        }
    }
}


var rect = Rectangle()
rect.width = 3.0
rect.height = 4.5
rect.area
rect.area = 9

class PropertyObserverExample{
    var number : Int = 0{
        willSet(newNumber){
        println("abt 2 change 2 \(newNumber)")
        }
        didSet(oldNumber){
            println("Just changed from \(oldNumber) to (self.number)!")
        }
    }
    
}

var observer = PropertyObserverExample()
observer.number = 4

//protocol
protocol Blinking{
    var isBlinking : Bool{get}
    var blinkSpeed:Double{get set}
    func startBlinking(blinkSpeed:Double) ->Void
}

class Light:Blinking{
    var isBlinking:Bool = false
    var blinkSpeed:Double = 0.0
    func startBlinking(blinkSpeed: Double) {
        println("I am now blinking")
        isBlinking = true
        self.blinkSpeed = blinkSpeed
    }
}

var aBlinkingThing:Blinking?
aBlinkingThing = Light()
aBlinkingThing?.startBlinking(4.0)
aBlinkingThing?.blinkSpeed


//extension
extension Int{
    var doubled:Int{
        return self * 2
    }
    func multiplyWith(anotherNumber:Int)-> Int{
        return self*anotherNumber
    }
}

2.doubled
4.multiplyWith(32)

//math

class Vector2D{
    var x:Float = 0.0
    var y:Float = 0.0
    init(x:Float,y:Float){
        self.x = x
        self.y = y
    }
}

func +(left:Vector2D,right:Vector2D) ->Vector2D{
    let result = Vector2D(x:left.x+right.x,y:left.y+right.y)
    return result
}

let first = Vector2D(x:2,y:10)
let second = Vector2D(x:5,y:4)
let result = first+second
















