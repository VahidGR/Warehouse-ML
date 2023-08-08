//
//  GoodsEntry.swift
//  
//
//  Created by Vahid Ghanbarpour on 8/8/23.
//

import Foundation
@testable import Warehouse

struct Fruit: Goods {
    let expiry_date: Date
    let name: Name
    
    init(expiry: TimeInterval, name: Name) {
        self.expiry_date = Date().addingTimeInterval(expiry)
        self.name = name
    }
    
    enum Name {
        case apple
        case orange
    }
}

struct Meat: Goods {
    let expiry_date: Date
    let name: Name
    
    init(expiry: TimeInterval, name: Name) {
        self.expiry_date = Date().addingTimeInterval(expiry)
        self.name = name
    }
    
    enum Name {
        case fish
        case beaf
    }
}

struct Vegetable: Goods {
    let expiry_date: Date
    let name: Name
    
    init(expiry: TimeInterval, name: Name) {
        self.expiry_date = Date().addingTimeInterval(expiry)
        self.name = name
    }
    
    enum Name {
        case parsey
        case mint
    }
}
