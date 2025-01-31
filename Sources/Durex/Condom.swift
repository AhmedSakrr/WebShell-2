//
//  File.swift
//  
//
//  Created by john on 2023/2/15.
//

import Foundation

#if canImport(Combine)
import Combine
#endif

public protocol Condom<Output> {
    associatedtype Input: ContextValue
    associatedtype Output: ContextValue
    
    /// 捕获输入，返回异步任务
    /// - Parameter inputValue: 输入数据
    /// - Returns: AnyPublisher异步任务
    func publisher(for inputValue: Input) -> AnyPublisher<Output, Error>
    /// 没有输入数据，返回异步结果，可以返回Error
    /// - Returns: AnyPublisher异步任务
    func empty() -> AnyPublisher<Output, Error>
}

extension Condom {
    public func join<T>(_ box: T) -> AnyCondom<Self.Input, T.Output> where T: Condom, T.Input == Self.Output {
        AnyCondom(self, last: box)
    }
    
    public func eraseToAnyCondom() -> AnyCondom<Input, Output> {
        AnyCondom(self)
    }
}
