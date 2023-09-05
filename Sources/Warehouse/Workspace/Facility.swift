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
		return firstAvailableSpace == nil
	}
	
	/// find index to place new item
	
	private var firstAvailableSpace: Int? {
		/*
		return firstAvailableSpace
		 */
	}
	
	init(capacity: Int) {
		/// create array with size of capacity
		/*
		self.goods = /// a fixed size of capacity
		 */
	}
	
	func store<T>(_ goods: T) throws where T: Goods {
		/// `Goods` must match `U`
		/// Facility must have enough storage space for `goods`. If not, throw `WarehouseError.full`
		/// To make it efficient for the facility worker, item must be placed at the ``first available space``
		///
		///
		/// Add item without change array size
		///
		/// If tem is irrelevant, throw `WarehouseError.unsupportedGoods`
	}
	
    func collectReport() -> Facility.Report {
		/// Fill in number of items inside this facility
		return .init(capacity: goods.count, isAtFullCapacity: isAtFullCapacity, filledPlaces: <#Int#>)
    }
    
    struct Report {
        let capacity: Int
        let isAtFullCapacity: Bool
        let filledPlaces: Int?
    }
}
