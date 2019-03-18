//
//  Bindable.swift
//  CultureAR
//
//  Created by Ahmad Karkouty on 3/18/19.
//  Copyright © 2019 Ahmad Karkouti. All rights reserved.
//

import Foundation


struct Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    mutating func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}

public func createObject<Element>(_ setup: ((Element) -> Void)) -> Element where Element: NSObject {
    let object = Element()
    setup(object)
    return object
}

