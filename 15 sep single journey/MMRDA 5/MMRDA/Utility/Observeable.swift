//
//  Observeable.swift
//  Salem Smart City
//
//  Created by Sandip Patel on 01/07/22.
//

import Foundation

class Observable<T> {
    typealias Listener = (T) -> Void
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
