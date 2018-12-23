//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation

public extension CD where Base: UIImageView {
    @discardableResult
    func image(_ a:UIImage) -> CD {
        base.image = a
        return self
    }
    @discardableResult
    func highlighted(_ image:UIImage) -> CD {
        base.highlightedImage = image
        return self
    }
    @discardableResult
    func isHighlighted(_ a:Bool) -> CD {
        base.isHighlighted = a
        return self
    }
    @discardableResult
    func animation(_ images:[UIImage]) -> CD {
        base.animationImages = images
        return self
    }
    
    @discardableResult
    func highlighted(_ animationImages:[UIImage]) -> CD {
        base.highlightedAnimationImages = animationImages
        return self
    }
    
    @discardableResult
    func animation(_ duration:TimeInterval) -> CD {
        base.animationDuration = duration
        return self
    }
    @discardableResult
    func animation(_ repeatCount:Int) -> CD {
        base.animationRepeatCount = repeatCount
        return self
    }
    @discardableResult
    func startAnimating() -> CD {
        base.startAnimating()
        return self
    }
    @discardableResult
    func stopAnimating() -> CD {
        base.stopAnimating()
        return self
    }
    
    @discardableResult
    func animation(_ images:[UIImage], duration:TimeInterval = 1, repeatCount:Int = 1) -> CD {
        base.animationImages = images
        base.animationDuration = duration
        base.animationRepeatCount = repeatCount
        base.startAnimating()
        return self
    }
    @discardableResult
    func animation(_ names:[String], duration:TimeInterval = 1, repeatCount:Int = 1) -> CD {
        //let images:[UIImage] = try names.map{ UIImage(named: $0)}
        var images:[UIImage] = []
        for item in names {
            guard let img = UIImage(named: item) else{
                assertionFailure("👉👉👉 UIImage(named: \(item))错误，w请检查 names")
                continue
            }
            images.append(img)
        }
        guard images.count > 0 else {
            return self
        }
        base.animationImages = images
        base.animationDuration = duration
        base.animationRepeatCount = repeatCount
        base.startAnimating()
        return self
    }
}
