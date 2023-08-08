//
//  WarehouseErrorTests.swift
//  
//
//  Created by Vahid Ghanbarpour on 8/8/23.
//

import XCTest
@testable import Warehouse

final class WarehouseErrorTests: XCTestCase {
    
    func testErrorCase_badGoods() {
        XCTAssertEqual(WarehouseError.badGoods.localizedDescription,
                       "All goods are expired. Charge client for a fine!")
    }
    func testErrorCase_unsupportedFacility() {
        XCTAssertEqual(WarehouseError.unsupportedFacility.localizedDescription,
                       "We don't have a facility to hold this type of goods. Build one!")
    }
    
    func testErrorCase_unsupportedGoods() {
        XCTAssertEqual(WarehouseError.unsupportedGoods.localizedDescription,
                       "Wrong goods in this facility. There is an error in Quality Assurance.")
    }
    
    func testErrorCase_full() {
        XCTAssertEqual(WarehouseError.full.localizedDescription,
                       "Facility is at full capacity! Build new ones or take out some items.")
    }
    
}
