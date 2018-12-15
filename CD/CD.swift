//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation

public struct CD<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}
public protocol CD_Compatible {
    associatedtype CompatibleType
    var cd: CompatibleType { get }
}
public extension CD_Compatible {
    public var cd: CD<Self> {
        return CD(self)
    }
}

extension NSObject: CD_Compatible {}

