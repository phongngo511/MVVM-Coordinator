//
//  Publisher+Extensions.swift
//  WeatheryKit
//
//  Created by Phu Phong Ngo on 5/6/2023.
//

import Foundation
import Combine

public extension Publisher where Output == Data {
    func decode<T: Decodable>(as type: T.Type = T.self, using decoder: JSONDecoder = .defaultSecondsSince1970Converting) -> Publishers.Decode<Self, T, JSONDecoder> {
        decode(type: type, decoder: decoder)
    }
}

public extension Publisher {
    func validate(using validator: @escaping(Output) throws -> Void) -> Publishers.TryMap<Self, Output> {
        tryMap { output in
            try validator(output)
            return output
        }
    }

    func unwrap<T>(orThrow error: @escaping @autoclosure () -> Failure) -> Publishers.TryMap<Self, T> where Output == Optional<T> {
        tryMap { output in
            switch output {
                case .some(let value):
                    return value
                case nil:
                    throw error()
            }
        }
    }
}
