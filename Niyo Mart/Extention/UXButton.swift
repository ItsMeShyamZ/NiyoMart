
import UIKit
import Foundation

let Localize : Localizations = Localizations.instance

public enum FontType{
    case bold
    case light
    case regular
}

extension UIButton{
    
    public func setText(_ textKey : String , _ size : Int = 20 , _ type : FontType = .bold,textColor color : UIColor = UIColor.white , bgColor : UIColor = UIColor.primaryColor){
        var fontStyle : String = ""
        switch type {
        case .bold:
            fontStyle = "Calibri-Bold"
        case .light:
            fontStyle = "Calibri-Light"
        case .regular:
            fontStyle = "Calibri"
        default:
            fontStyle = "Calibri"
        }
        self.backgroundColor = bgColor
        let customButtonTitle = NSMutableAttributedString(string: Localize.stringForKey(key: textKey), attributes: [
            NSAttributedString.Key.font:UIFont(name: fontStyle, size: CGFloat(size)) ?? UIFont.systemFont(ofSize: CGFloat(size)),
            NSAttributedString.Key.foregroundColor : color
        ])
        self.setAttributedTitle(customButtonTitle, for: .normal)
    }
    
    
    func setImage(_ name : AssetName , _ withTint : YesNoType = .no, _ withTintColor : UIColor = UIColor.whiteColor ){
            if withTint == .no{
                self.setImage((UIImage(named: name.rawValue) ?? UIImage()), for: .normal)
               
            }else{
                if #available(iOS 13.0, *) {
                    self.setImage((UIImage(named: name.rawValue) ?? UIImage()).withTintColor(withTintColor), for: .normal)
                   
                } else {
                    if let TintImage = (UIImage(named: name.rawValue)){
                        let tintableImage = TintImage.withRenderingMode(.alwaysTemplate)
                      
                        self.setImage(tintableImage, for: .normal)
                    }
                    self.tintColor = withTintColor
                    self.setImage(self.image(for: .normal)?.imageWithColor(color: UIColor.white ), for: .normal)
                }
            }
        }
}
