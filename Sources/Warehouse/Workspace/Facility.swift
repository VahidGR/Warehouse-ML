//
//  Facility.swift
//  
//
//  Created by Vahid Ghanbarpour on 8/8/23.
//

import Foundation

final class Facility<U: Goods>: Storage {
    
    private var goods: [U?]
    
    public var isAtFullCapacity: Bool {
        return placingIndex == nil
    }
    
    private var placingIndex: Int? {
        return self.goods.firstIndex(where: { $0 == nil })
    }
    
    init(capacity: Int) {
        goods = .init(repeating: nil, count: capacity)
    }
    
    func store<T>(_ goods: T) throws {
        guard let place = placingIndex
        else
        {
            throw WarehouseError.full
        }
        guard let item = goods as? U
        else
        {
            throw WarehouseError.unsupportedGoods
        }
        
        self.goods[place] = item
    }
    
    func collectReport() -> Facility.Report {
        return .init(capacity: goods.count, isAtFullCapacity: isAtFullCapacity, filledPlaces: placingIndex)
    }
    
    struct Report {
        let capacity: Int
        let isAtFullCapacity: Bool
        let filledPlaces: Int?
    }
}
