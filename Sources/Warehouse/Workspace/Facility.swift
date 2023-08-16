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
    
    /// find index to place new item
    private var placingIndex: Int? {
        return self.goods.firstIndex(where: { $0 == nil })
    }
    
    init(capacity: Int) {
        // create array with spacific size
        // return array with size of capacity
    }
    
    func store<T>(_ goods: T) throws {
        
        /// Add item without change array size - level junior
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
        /// Item is relevant
        /// There's space for one goods at least
        // Add item here
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
