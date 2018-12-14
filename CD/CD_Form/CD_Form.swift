//Created  on 2018/12/13  by LCD :https://github.com/liucaide .

import Foundation

public struct CD_Form {
    public var rows:[CD_RowProtocol]
    public init(_ rows:[CD_RowProtocol] = []) {
        self.rows = rows
    }
    public mutating func append(_ row:CD_RowProtocol) {
        self.rows.append(row)
    }
    public mutating func insert(_ row:CD_RowProtocol, at:Int) {
        self.rows.insert(row, at: at)
    }
}
