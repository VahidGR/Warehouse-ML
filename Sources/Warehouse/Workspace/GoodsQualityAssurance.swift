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
        /// Throw out all of the spoiled good
        /// If all of the goods are expired, throw badGoods error of WarehouseError, that should fine the client
    }
}
