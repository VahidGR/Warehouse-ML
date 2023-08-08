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
    
    func tailorGoods(_ goods: inout [Goods]) throws {
        
        goods = goods.filter({ [weak self] item in
            guard let self else { return false }
            return item.expiry_date >= self.warehouseThresholdPolicy
        })
        
        let someGoodsAreReadyToStore = !goods.isEmpty
        
        guard someGoodsAreReadyToStore
        else {
            throw WarehouseError.badGoods
        }
    }
}
