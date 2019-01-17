//Created  on 2018/12/11  by LCD :https://github.com/liucaide .

import Foundation

public protocol CD_VMProtocol {
    associatedtype Input
    associatedtype Output
    func put(_ input: Input) -> Output
}
