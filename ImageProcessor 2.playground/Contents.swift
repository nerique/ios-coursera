import UIKit

class imageProcessor {
    
    var image: String
    var myUIImg: UIImage?
    var myRGBAImg: RGBAImage?
    enum Filters : String {
        case Red
        case Green
        case Blue
        case HighContrast
        case Blur
        case GreyScale
        case Brightness25 = "25% Brightness"
        case Brightness50 = "50% Brightness"
        case Brightness150 = "150% Brightness"
    }
    var myFilter: Filters?
    var avgRed: Int = 0
    var avgBlue: Int = 0
    var avgGreen: Int = 0
    var calculatedAvg: Bool = false
    
    required init(image: String) {
        self.image = image
        self.loadImage()
        self.calculatedAvg = false
    }
    
    func loadImage() {
        self.myUIImg = UIImage(named: image)
    }
    
    func convertToRGBA() {
        self.myRGBAImg = RGBAImage(image: self.myUIImg!)
    }
    
    func convertRGBAToImage() {
        self.myUIImg = self.myRGBAImg!.toUIImage()
    }
    
    func applyFilter(filter: String) -> imageProcessor {
        self.myFilter = Filters(rawValue: filter)
        if (self.myFilter != nil) {
            self.filter()
        } else {
            print("Filter ", filter, " does not exist")
        }
        return self
    }
    
    func filter() {
        print("Setting filter")
        switch self.myFilter! {
        case imageProcessor.Filters.Red:
            self.redFilter()
            break
        case imageProcessor.Filters.Green:
            self.greenFilter()
            break
        case imageProcessor.Filters.Blue:
            self.blueFilter()
            break
        case imageProcessor.Filters.Blur:
            self.blurFilter()
            break
        case imageProcessor.Filters.HighContrast:
            self.highContrastFilter()
            break
        case imageProcessor.Filters.GreyScale:
            self.greyScaleFilter()
            break
        case imageProcessor.Filters.Brightness25:
            self.brightnessFilter(25)
            break
        case imageProcessor.Filters.Brightness50:
            self.brightnessFilter(50)
            break
        case imageProcessor.Filters.Brightness150:
            self.brightnessFilter(150)
            break
        default:
            print("Unknown filter: ", self.myFilter)
            break
        }
    }
    
    func render() -> UIImage {
        return self.myUIImg!
    }
    
    func redFilter() {
        self.convertToRGBA()
        if (!calculatedAvg) {
            self.calculateAvg()
        }
        for y in 0..<self.myRGBAImg!.height {
            for x in 0..<self.myRGBAImg!.width {
                let index = y * self.myRGBAImg!.width + x
                var pixel = self.myRGBAImg!.pixels[index]
                let colorDiff = Int(pixel.red) - self.avgRed
                if colorDiff > 0 {
                    pixel.red = UInt8(max(0, min(255, self.avgRed + colorDiff * 5)))
                    self.myRGBAImg!.pixels[index] = pixel
                }
            }
        }
        self.convertRGBAToImage()
    }
    
    func blueFilter() {
        self.convertToRGBA()
        if (!calculatedAvg) {
            self.calculateAvg()
        }
        for y in 0..<self.myRGBAImg!.height {
            for x in 0..<self.myRGBAImg!.width {
                let index = y * self.myRGBAImg!.width + x
                var pixel = self.myRGBAImg!.pixels[index]
                let colorDiff = Int(pixel.blue) - self.avgBlue
                if colorDiff > 0 {
                    pixel.blue = UInt8(max(0, min(255, self.avgBlue + colorDiff * 5)))
                    self.myRGBAImg!.pixels[index] = pixel
                }
            }
        }
        self.convertRGBAToImage()
    }
    
    func greenFilter() {
        self.convertToRGBA()
        if (!calculatedAvg) {
            self.calculateAvg()
        }
        for y in 0..<self.myRGBAImg!.height {
            for x in 0..<self.myRGBAImg!.width {
                let index = y * self.myRGBAImg!.width + x
                var pixel = self.myRGBAImg!.pixels[index]
                let colorDiff = Int(pixel.green) - self.avgGreen
                if colorDiff > 0 {
                    pixel.green = UInt8(max(0, min(255, self.avgGreen + colorDiff * 5)))
                    self.myRGBAImg!.pixels[index] = pixel
                }
            }
        }
        self.convertRGBAToImage()
    }
    
    func highContrastFilter() {
        self.convertToRGBA()
        if (!calculatedAvg) {
            self.calculateAvg()
        }
        
        for y in 0..<self.myRGBAImg!.height {
            for x in 0..<self.myRGBAImg!.width {
                let index = y * self.myRGBAImg!.width + x
                var pixel = self.myRGBAImg!.pixels[index]
                let redDelta = Int(pixel.red) - self.avgRed
                let greenDelta = Int(pixel.green) - self.avgGreen
                let blueDelta = Int(pixel.blue) - self.avgBlue
                pixel.red = UInt8(max(min(255, self.avgRed + 3 * redDelta), 0))
                pixel.green = UInt8(max(min(255, self.avgGreen + 3 * greenDelta), 0))
                pixel.blue = UInt8(max(min(255, self.avgBlue + 3 * blueDelta), 0))
                self.myRGBAImg!.pixels[index] = pixel
            }
        }
        self.convertRGBAToImage()
    }
    
    func greyScaleFilter() {
        let imageRect:CGRect = CGRectMake(0, 0, self.myUIImg!.size.width, self.myUIImg!.size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let width = self.myUIImg!.size.width
        let height = self.myUIImg!.size.height
    
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.None.rawValue)
        let context = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, colorSpace, bitmapInfo.rawValue)
    
        CGContextDrawImage(context, imageRect, self.myUIImg!.CGImage)
        let imageRef = CGBitmapContextCreateImage(context)
        self.myUIImg = UIImage(CGImage: imageRef!)

    }
    
    func blurFilter() {
        let imageToBlur = CIImage(image: self.myUIImg!)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
        let resultImage = blurfilter!.valueForKey("outputImage") as! CIImage
        self.myUIImg = UIImage(CIImage: resultImage)
    }
    
    func brightnessFilter(percent: Int) {
        // Calculate the adjustment multiplier
        let adjust = Double(percent) / 100
        self.convertToRGBA()
        // Filter the image:
        for y in 0..<self.myRGBAImg!.height {                     // For each y location
            for x in 0..<self.myRGBAImg!.width {                  // For each x location
                let index = y * self.myRGBAImg!.width + x         // Grab the index of that coordinate [x,y]
                var pixel = self.myRGBAImg!.pixels[index]         // Get the pixel object of that index
                
                // Modify the pixel by the adjustment percentage
                let red = round(Double(pixel.red) * adjust)
                let blue = round(Double(pixel.blue) * adjust)
                let green = round(Double(pixel.green) * adjust)
                
                // Update the pixel
                pixel.red = UInt8( max (0, min (255, red)))
                pixel.blue = UInt8( max (0, min (255, blue)))
                pixel.green = UInt8( max (0, min (255, green)))
                
                //Write the pixel back to the RGBA Image
                self.myRGBAImg!.pixels[index] = pixel
            }
        }
        self.convertRGBAToImage()
    }
    
    func calculateAvg() {
        var totalRed = 0
        var totalGreen = 0
        var totalBlue = 0
        
        for y in 0..<self.myRGBAImg!.height {
            for x in 0..<self.myRGBAImg!.width {
                let index = y * self.myRGBAImg!.width + x
                
                var pixel = self.myRGBAImg!.pixels[index]
                
                totalRed += Int(pixel.red)
                totalGreen += Int(pixel.green)
                totalBlue += Int(pixel.blue)
            }
        }
        
        let count = self.myRGBAImg!.width * self.myRGBAImg!.height
        self.avgRed = totalRed/count
        self.avgGreen = totalGreen/count
        self.avgBlue = totalBlue/count
        self.calculatedAvg = true
    }
    
}

let image = imageProcessor(image: "sample")
//image.applyFilter("50% Brightness").render()
//image.applyFilter("GreyScale").render()
//image.applyFilter("HighContrast").applyFilter("GreyScale").render()
//image.applyFilter("HighContrast").render()
//image.applyFilter("Blur").render()
//image.applyFilter("Red").render()
image.applyFilter("Red").applyFilter("150% Brightness").render()
//image.applyFilter("Blue").render()
//image.applyFilter("Green").render()
