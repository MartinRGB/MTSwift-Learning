//: Playground - noun: a place where people can play

import UIKit
//泛型
class Tree <T>{
    var value:T
    var children : [Tree<T>] = []
    init(value : T){
        self.value = value
    }
    
    func addChild(value:T) -> Tree<T>{
        let newChild = Tree<T>(value:value)
        children.append(newChild)
        return newChild
    }
}

let integerTree = Tree<Int>(value:5)

integerTree.addChild(10)
integerTree.addChild(5)


let stringTree = Tree<String>(value:"Hello")
stringTree.addChild("Yes")
stringTree.addChild("Internets")

//String

var composingAString = "Hello"
composingAString += ",World"

var reversedString = ""
for character in "Hello"{
    reversedString = String(character) + reversedString
}
reversedString

count(reversedString)
//Compare
let string1:String = "Hello"
let string2:String = "Hel"+"lo"
if string1 == string2{
    println("equal")
}

//Pre Suf
if string1.hasSuffix("o"){
    println("string1 has an o")
}

if string2.hasPrefix("H"){
    println("string2 has an H")
}

//data
let stringToConvert = "Hello,Swift"
let data = stringToConvert.dataUsingEncoding(NSUTF8StringEncoding)

//en de

class SerializableObject : NSObject,NSCoding{
    var name :String?
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name!,forKey:"name")
    }
    override init(){
        self.name = "My Object"
    }
    required init(coder aDecoder:NSCoder){
        self.name = aDecoder.decodeObjectForKey("name")as?String
    }
}


let anObject = SerializableObject()
anObject.name = "My Thing That I'm Saving"

let objectConvertedToData = NSKeyedArchiver.archivedDataWithRootObject(anObject)

let loadedObject = NSKeyedUnarchiver.unarchiveObjectWithData(objectConvertedToData) as? SerializableObject

loadedObject?.name


//delegate
//定义一个协议，它有一个handleIntruder啊还是农户
protocol HouseSecurityDelegate{
    //指明认为作为HSDelegate的类都必须有handleIntruder（）函数
    func handleIntruder()
}
class House{
    //委托可以是任何遵守HSDelegate协议的对象
    var delegate:HouseSecurityDelegate?
    
    func burglarDetected(){
        //查看是否有委托，然后调用
        delegate?.handleIntruder()
    }
}

class GuardDog:HouseSecurityDelegate{
    func handleIntruder(){
        println("Releasing the hounds!")
    }
}

let myHouse = House()
myHouse.burglarDetected()

let theHounds = GuardDog()
myHouse.delegate = theHounds
myHouse.burglarDetected()


let notificationCenter = NSNotificationCenter.defaultCenter()

let operationQueue = NSOperationQueue.mainQueue()

let applicationDidEnterBackgroundObserver = notificationCenter.addObserverForName(UIApplicationDidEnterBackgroundNotification,object:nil,queue:operationQueue){
    (notification:NSNotification!)in
    println("Hello")
}







