//
//  throw.swift
//  SwiftDataStructure
//
//  Created by Augus on 2021/6/26.
//

import Foundation

enum MyError: Error {
    case SampleError
    case HttpError
    case IOError
}

func throwMe(shouldThtor: Bool) throws -> Bool {
    if shouldThtor {
        throw MyError.SampleError
    }
    return true
}




