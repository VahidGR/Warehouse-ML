//
//  GoodsQualityAssurance.swift
//  
//
//  Created by Vahid Ghanbarpour on 8/8/23.
//

import Foundation

final class GoodsQualityAssurance: QualityAssurance {
    
    private let warehouseThresholdPolicy: Date
    
    init(threshold: TimeInterval) {
        self.warehouseThresholdPolicy = Date().addingTimeInterval(threshold)
    }
    
    /// filter goods base on expiry_date and warehouseThresholdPolicy
    /// - Parameter goods: goods that require to filter
    func tailorGoods(_ goods: inout [Goods]) throws {
        
        //for junior level
        goods = goods.filter({ [weak self] item in
            guard let self else { return false }
            return item.expiry_date >= self.warehouseThresholdPolicy
        })
        
        //for mid+ level
        let someGoodsAreReadyToStore = !goods.isEmpty
        
        guard someGoodsAreReadyToStore
        else {
            throw WarehouseError.badGoods
        }
    }
}
