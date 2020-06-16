import UIKit
import Foundation

public protocol CD_ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    func put(_ input: Input) -> Output
}

struct ViewModel{
    struct Input {
        let id = ""
    }
    struct Output {
        let arr:[Int] = []
    }
}

extension ViewModel: CD_ViewModelProtocol {
    func put(_ input: ViewModel.Input) -> ViewModel.Output {
        return Output()
    }
}

struct Network {
    static func post() -> [Int] {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            return [1,2,3]
        }
    }
}

extension ViewModel.Input {
    func requestArr() -> [Int] {
        return Network.post()
    }
}
