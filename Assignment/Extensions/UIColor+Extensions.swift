import UIKit

enum ColorType: String {
    case BackgroundColor
    case ThemeColor
}

extension UIColor {
    class var backgroundColor: UIColor {
        guard let color = UIColor(named: ColorType.BackgroundColor.rawValue) else {
            fatalError("Missing \(ColorType.BackgroundColor.rawValue) in Colors.xcassets")
        }
        
        return color
    }
    
    class var themeColor: UIColor {
        guard let color = UIColor(named: ColorType.ThemeColor.rawValue) else {
            fatalError("Missing \(ColorType.ThemeColor.rawValue) in Colors.xcassets")
        }
        
        return color
    }
}
