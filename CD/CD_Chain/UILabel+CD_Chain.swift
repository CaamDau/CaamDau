//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation
import UIKit

public extension CD where Base: UILabel {
    @discardableResult
    func text(_ txt: String) -> CD {
        base.text = txt
        return self
    }
    @discardableResult
    func text(_ color: UIColor) -> CD {
        base.textColor = color
        return self
    }
    @discardableResult
    func font(_ a: UIFont) -> CD {
        base.font = a
        return self
    }
    @discardableResult
    func text(_ alignment: NSTextAlignment) -> CD {
        base.textAlignment = alignment
        return self
    }
    @discardableResult
    func number(_ ofLines: Int) -> CD {
        base.numberOfLines = ofLines
        return self
    }
    @discardableResult
    func attributed(_ text:NSAttributedString) -> CD {
        base.attributedText = text
        return self
    }
    @discardableResult
    func line(_ breakMode:NSLineBreakMode) -> CD {
        base.lineBreakMode = breakMode
        return self
    }
    @discardableResult
    func baseline(_ adjustment:UIBaselineAdjustment) -> CD {
        base.baselineAdjustment = adjustment
        return self
    }
    @discardableResult
    func allows(_ defaultTighteningForTruncation:Bool) -> CD {
        base.allowsDefaultTighteningForTruncation = defaultTighteningForTruncation
        return self
    }
    @discardableResult
    func preferred(_ maxLayoutWidth:CGFloat) -> CD {
        base.preferredMaxLayoutWidth = maxLayoutWidth
        return self
    }
    @discardableResult
    func adjusts(_ fontSizeToFitWidth:Bool) -> CD {
        base.adjustsFontSizeToFitWidth = fontSizeToFitWidth
        return self
    }
    @discardableResult
    func highlighted(_ textColor:UIColor) -> CD {
        base.highlightedTextColor = textColor
        return self
    }
    @discardableResult
    func minimum(_ scaleFactor:CGFloat) -> CD {
        base.minimumScaleFactor = scaleFactor
        return self
    }
    
    /*
    @discardableResult
    func line(_ spacing:CGFloat) -> CD {
        var textDic =
            [NSAttributedString.Key.foregroundColor:base.textColor,
             NSAttributedString.Key.font:base.font]
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        textDic[NSAttributedString.Key.paragraphStyle] = style
        if base.text!.count > 0 {
            base.attributedText = NSAttributedString(string: base.text!, attributes: textDic)
        }
        else if base.attributedText!.length > 0 {
            var attStr =  NSMutableAttributedString(attributedString: base.attributedText ?? NSAttributedString(string: base.text!))
            attStr.setAttributes(textDic, range: NSMakeRange(0, base.attributedText!.length))
        }
        return self
    }*/
    
    
}
