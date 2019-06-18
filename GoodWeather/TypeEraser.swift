//
//  TypeEraser.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/18/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import Foundation
// Type Eraser
class Dynamic<T>: Codable where T: Codable {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        self.listener?(self.value)
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
    
}
