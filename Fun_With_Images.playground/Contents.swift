//: Playground - noun: a place where people can play

import UIKit

//Image processing


//let image = UIImage(named: "forest.png")!
//let image = UIImage(named: "forest-icon.png")!
let image = UIImage(named: "sample.png")!

let myRGBA = RGBAImage(image: image)!
/*
let x=10
let y=10

let index = y * myRGBA.width + x

var pixel = myRGBA.pixels[index]

pixel.red
pixel.green
pixel.blue

pixel.red = 255
pixel.green = 0
pixel.blue = 0

myRGBA.pixels[index] = pixel
let newImage = myRGBA.toUIImage()


//Average color the image has

var totalRed = 0
var totalGreen = 0
var totalBlue = 0

for y in 0..<myRGBA.height {
    for x in 0..<myRGBA.width {
        let index = y * myRGBA.width + x
        
        var pixel = myRGBA.pixels[index]
        
        totalRed += Int(pixel.red)
        totalGreen += Int(pixel.green)
        totalBlue += Int(pixel.blue)
    }
}

let count = myRGBA.width * myRGBA.height
let avgRed = totalRed/count
let avgGreen = totalGreen/count
let avgBlue = totalBlue/count
*/
let avgRed = 119
let avgGreen = 98
let avgBlue = 83

for y in 0..<myRGBA.height {
    for x in 0..<myRGBA.width {
        let index = y * myRGBA.width + x
        var pixel = myRGBA.pixels[index]
        let redDiff = Int(pixel.red) - avgRed
        if redDiff > 0 {
            pixel.red = UInt8(max(0, min(255, avgRed + redDiff * 5)))
            //We can divide by 5 instead of * to have a less red image
            //pixel.red = UInt8(max(0, min(255, avgRed + redDiff * 5)))
            myRGBA.pixels[index] = pixel
        }
        
    }
}

let newImage2 = myRGBA.toUIImage()

