import Foundation

final class Warehouse {
    
    private let qualityAssurance: QualityAssurance
    
    private let storageFacility: ColdStorage
    
    init(qualityAssurance: QualityAssurance, storageFacility: ColdStorage) {
        self.qualityAssurance = qualityAssurance
        self.storageFacility = storageFacility
    }
    
    func store(_ goods: inout [Goods]) throws {
        try qualityAssurance.tailorGoods(&goods)
        try coldStorageSupervisor(store: goods)
    }
    
    private func coldStorageSupervisor(store goods: [Goods]) throws {
        let dispatchGroup = DispatchGroup()
        var errors: [Error] = []

        for item in goods {
            dispatchGroup.enter()
            DispatchQueue.global(qos: .utility).sync { [weak self] in
                guard let self else { return }
                defer { dispatchGroup.leave() }
                do {
                    try self.storageFacility.store(item)
                } catch {
                    errors.append(error)
                }
            }
        }

        dispatchGroup.wait()

        if !errors.isEmpty {
            throw CombinedError(errors: errors)
        }
    }
    
    public func collectReport<T: Goods>(for goods: T.Type) throws -> [Facility<T>.Report] {
        return try storageFacility.collectReport(for: T.self)
    }
}

struct CombinedError: Error {
    let errors: [Error]
}
