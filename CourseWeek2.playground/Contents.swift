//: Playground - noun: a place where people can play

import UIKit

var str:String? = "Hello"

str = "Hey"

let constantString = "Hello"

print(str)

//Simple Control Flow - If Statements

let name = "Johnathan"

if name.characters.count > 10 {
    print("Long Name")
} else if name.characters.count > 5 {
    print("Medium Name")
} else {
    print("Short Name")
}

//Simple Control Flow - Switch Statements

switch name .characters.count {
case 7...10:
    print("Long Name")
case 5..<7:
    print("Medium Name")
default:
    print("some length")
    
}

//Simple Control Flow - Loops

var number = 0
while number < 10 {
    number * number
    number += 1
}

for number in 0..<10 {
    number
}

for number in [2,5,1,9,6] {
    number
}

//Arrays and Dictionaries

var animals:[String] = ["Cow", "Dog", "Bunny"]
animals[0]
animals[2] = "Rabbit"
animals
//animals[4] --> will crash

for animal in animals {
    animal
}

var cuteness = ["Cow": "Not very",
                "Dog": "Cute",
                "Bunny" : "Very cute"]
let dogsCuteness = cuteness["Dog"]
cuteness["Cat"] //does not crash, you get a nil

for otherAnimal in animals {
    cuteness[otherAnimal]
}


//Functions

func doMath(a: Double, b:Double, operation:String) {
    print("performing", operation, "on", a, "and", b)
}

//doMath() will crash as no params
doMath(2.0, b:1.0, operation: "+")

func perform(operation:String, on a:Double, and b:Double) -> Double {
    print("performing", operation, "on", a, "and", b)
    
    var result:Double = 0
    switch operation {
        case "+": result = a + b
        case "-": result = a - b
        case "*": result = a * b
        case "/": result = a / b
        default: print ("Bad operation:", operation)
    }
    return result
}

let result = perform("/", on: 1.0, and: 2.0)

//2D Arrays

var image = [
    [3, 7, 10],
    [6, 4, 2],
    [8, 5, 2]
]

func raiseLowerValuesOfImageOne(image:[[Int]]) {
    for row in image {
        for col in row {
            print (col)
        }
    }
}

func raiseLowerValuesOfImageTwo(image:[[Int]]) {
    var image = image
    for row in 0..<image.count {
        for col in 0..<image[row].count {
            print (image[row][col])
            if (image[row][col] < 5) {
                image[row][col] = 5
            }
        }
    }
    image
}

raiseLowerValuesOfImageTwo(image)
image

func raiseLowerValuesOfImage(inout image:[[Int]]) {
    for row in 0..<image.count {
        for col in 0..<image[row].count {
            print (image[row][col])
            if (image[row][col] < 5) {
                image[row][col] = 5
            }
        }
    }
    image
}

raiseLowerValuesOfImage(&image)
image

for hdh in 0..<5 { print(hdh) }






