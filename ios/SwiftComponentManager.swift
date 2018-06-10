@objc (SwiftComponentManager)
class SwiftComponentManager: RCTViewManager {
  
  override func view() -> UIView! {
    let imageView = CustomImageView()
    imageView.image = #imageLiteral(resourceName: "nyc.jpg")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }
  
  func updateValueViaManager(_ node:NSNumber, filterName: NSString) {
    DispatchQueue.main.async {
      let myCustomImageView = self.bridge.uiManager.view(forReactTag: node) as! CustomImageView
      myCustomImageView.updateValue(filter: filterName as String)
    }
  }
}

class CustomImageView : UIImageView {
  
  static let context = CIContext(options: nil)
  let originalImage = #imageLiteral(resourceName: "nyc")
  var filePath : String?
  var filterName : String? {
    didSet{
      if CustomImageView.smallImage == nil {
      CustomImageView.smallImage = CustomImageView.resizeImage(image: originalImage, ratio: 0.3)
      }
      self.addFilterToImage(filterName: filterName!)
    }
  }
  static var smallImage: UIImage?
  static func resizeImage(image: UIImage, ratio: CGFloat) -> UIImage {
    let size = image.size
    
    let widthRatio  =  ratio
    let heightRatio = ratio
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
      newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
      newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
  func addFilterToImage(filterName:String){
    guard let filter = CIFilter(name: filterName) else { return }
    // use filepath to fetch image
    let image = CIImage(cgImage: (CustomImageView.smallImage?.cgImage)!)
    filter.setValue(image, forKey: kCIInputImageKey)
    guard let filterOutputImage = filter.outputImage else { return }
    let extent = filterOutputImage.extent
    let cgImg = CustomImageView.context.createCGImage(filterOutputImage, from: extent)
    let newImage = UIImage(cgImage: cgImg!)
    self.image = newImage
  }
  func updateValue(filter: String){
    
    guard let filter = CIFilter(name: filter) else { return }
    
    // use filepath to fetch image
    let image = CIImage(cgImage: (self.originalImage.cgImage)!)
    filter.setValue(image, forKey: kCIInputImageKey)
    guard let filterOutputImage = filter.outputImage else { return }
    let extent = filterOutputImage.extent
    let cgImg = CustomImageView.context.createCGImage(filterOutputImage, from: extent)
    let newImage = UIImage(cgImage: cgImg!)
    self.image = newImage
  }
  
}
