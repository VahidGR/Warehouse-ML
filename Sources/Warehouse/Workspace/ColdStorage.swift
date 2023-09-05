//
//  ColdStorage.swift
//  
//
//  Created by Vahid Ghanbarpour on 8/8/23.
//

import Foundation

struct ColdStorage: Storage {
    
    private var repositories: [Storage]
    
    init(repositories: [Storage]) {
        self.repositories = repositories
    }
    
    func store<T>(_ goods: T) throws where T : Goods {
        let facilities = try correspondingFacilities(for: T.self)
        guard let facility = facilities
            .first(where: { !$0.isAtFullCapacity })
        else
        {
            throw WarehouseError.full
        }
        try facility.store(goods)
    }
    
    func collectReport<T: Goods>(for goods: T.Type) throws -> [Facility<T>.Report] {
        let facilities = try correspondingFacilities(for: T.self)
        let reports: [Facility<T>.Report] = facilities.compactMap({
            $0.collectReport()
        })
        return reports
    }
    
    private func correspondingFacilities<T: Goods>(for goods: T.Type) throws -> [Facility<T>] {
		/// `self.repositories` is an array of facilities
		/// Each `Facility` is bound to support only one type of goods. ex: `Fruit`, `Meat`, `Vegies`
		/// Find all of facilities that support goods with type of `T`
		/// If no corresponding facility is found, throw `WarehouseError.unsupportedFacility`
        return facilities /// Corresponding to `T`
    }
}
