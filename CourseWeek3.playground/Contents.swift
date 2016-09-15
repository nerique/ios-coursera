//: Playground - noun: a place where people can play

import UIKit

var Str: String = "Hello, playground"

// Optionals

var MaybeStr: String? = "hi" //can be a string or a nil

MaybeStr!.characters.count // ! unwrapped the optionals

// Closures

func performMagic2(spell: String) -> String {
    return spell
}

performMagic2("disappear")

let magicFunction2 = performMagic2

magicFunction2("disappear")


func performMagic(spell: String) -> String {
    return spell
}

var newMagicFunction = {
    (spell: String) -> String in
    return spell;
}

newMagicFunction("disappear")

// Properties

struct Animal2 {
    var name: String = ""
    var heightInches = 0.0
    var heightCM = 0.0
    //both heights are related
}

struct Animal {
    var name: String = ""
    var heightInches = 0.0
    var heightCM: Double {
        get {
            return 2.54*heightInches
        }
        set (newHeightCM) {
            heightInches = newHeightCM / 2.54
        }
    }
}

var dog = Animal (name: "dog", heightInches: 50)
dog.heightInches
dog.heightCM
dog.heightCM = 254
dog.heightCM
dog.heightInches

let noValue:Int? = nil
//let unwrappedValue = noValue! --> error

// Value Types

var a = 3
var b = a
b = 5
a
// on the lines before, changing b doesn't affect a

class number {
    var n: Int
    init(n: Int) {
        self.n = n
    }
}

var aNumber = number(n:3)
var bNumber = aNumber

bNumber.n = 5
bNumber.n
aNumber.n

//--> bNumber and aNumber are the same objects

struct valueNumber {
    var n: Int
    init(n: Int) {
        self.n = n
    }
}

var cNumber = valueNumber(n:3)
var dNumber = cNumber

dNumber.n = 5
dNumber.n
cNumber.n

//Struct creates a copy, but not a reference, so two different objects

//Cheat sheet

//Classes inheritance

class SuperNumber: NSNumber {
    override func getValue(value: UnsafeMutablePointer<Void>) {
        super.getValue(value)
    }
}

//Classes extensions

extension NSNumber {
    func superCoolGetter() -> Int {
        return 5
    }
}

let n = NSNumber(int: 4)
n.superCoolGetter()

//Protocols --> Interface to a class

protocol danceable {
    func dance() //We do not implement the function
}

class Person: danceable { //Conforms to protocols NSNumber and danceable
    func dance() {
        
    }
}

extension NSNumber: danceable {
    func superReCoolGetter() -> Int {
        return 5
    }
    
    func dance() {
        
    }
}

//Allows to make the code separated


//Enums

enum TypesOfVeggies : String {
    case Carrots //Can even have parameters
    case Tomatoes
    case Celery
}

let carrot = TypesOfVeggies.Carrots
carrot.rawValue

func eatVeggies(veggie: TypesOfVeggies) {
    
}

let randomVeggie = TypesOfVeggies(rawValue: "Carrots")
let randomVeggie2 = TypesOfVeggies(rawValue: "Lead")
eatVeggies(TypesOfVeggies.Carrots)

//Classes

class Car {
    var cupHolder: String = "two holders"
    
    required init(cupHolder: String) {
        self.cupHolder = cupHolder
    }
    
    convenience init () {
        self.init(cupHolder: "Cool")
    }
}

let car = Car(cupHolder: "Cool")
let newCar = Car()

class CarWithCups { //: NSString {
    var cupHolder: String
    
    required init(cupHolder: String) {
        self.cupHolder = cupHolder
        //super.init() //Because class inherits from NSString, you have to call the parent initializer
    }
    
    deinit {
        
    }
}

let car2 = CarWithCups(cupHolder: "Cool")

//Expert topics

//Swift support generics
//let a = Array<Element>

//Overload functions
//||Veggie => create a || operator


