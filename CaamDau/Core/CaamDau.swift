//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation

public struct CaamDau<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
    public var build: Base {
        return base
    }
}

public protocol CaamDauCompatible {
    associatedtype CompatibleType
    var cd: CompatibleType { get }
}
extension CaamDauCompatible {
    public var cd: CaamDau<Self> {
        return CaamDau(self)
    }
}

extension NSObject: CaamDauCompatible {}



