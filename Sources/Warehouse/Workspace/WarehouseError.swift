//
//  WarehouseError.swift
//  
//
//  Created by Vahid Ghanbarpour on 8/8/23.
//

import Foundation

enum WarehouseError: Error {
    case badGoods
    case unsupportedFacility
    case unsupportedGoods
    case full

    public var localizedDescription: String {
        switch self {
        case .badGoods:
            return "All goods are expired. Charge client for a fine!"
        case .unsupportedFacility:
            return "We don't have a facility to hold this type of goods. Build one!"
        case .unsupportedGoods:
            return "Wrong goods in this facility. There is an error in Quality Assurance."
        case .full:
            return "Facility is at full capacity! Build new ones or take out some items."
        }
    }
}
