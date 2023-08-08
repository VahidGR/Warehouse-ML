import XCTest
@testable import Warehouse

final class WarehouseTests: XCTestCase {
    private weak var warehouse: Warehouse!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = true
    }
    
    override func tearDown() {
        super.tearDown()
        XCTAssertNil(warehouse)
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        var goods: [Goods] = [
            Meat (expiry: 6_000,  name: .beaf),
            Meat (expiry: 9_000,  name: .beaf),
            
            Meat (expiry: 18_000, name: .fish),
            Meat (expiry: 7_000,  name: .fish),
            
            Fruit(expiry: 4_100,  name: .apple),
            Fruit(expiry: -5_000, name: .apple),
            Fruit(expiry: 4_200,  name: .apple),
            
            Fruit(expiry: -4_000, name: .orange),
            Fruit(expiry: 6_000,  name: .orange),
        ]
        
        let sut = buildWarehouse(qualityAssuranceThreshold: 4_100, facilities: [
            Facility<Fruit>(capacity: 4),
            Facility<Meat>(capacity: 4),
        ])
        
        try sut.store(&goods)
        
        try validateReport(of: Fruit.self, for: sut,
                           count: 1,
                           capacity: 4,
                           filledPlaces: 2,
                           isAtFullCapacity: false)

        try validateReport(of: Meat.self, for: sut,
                           count: 1,
                           capacity: 4,
                           filledPlaces: nil,
                           isAtFullCapacity: true)
        
        self.warehouse = sut
    }
    
    func testBadGoods() throws {
        var goods: [Goods] = [
            Meat (expiry: -4_000,  name: .beaf),
            Meat (expiry: -9_000,  name: .beaf),
            
            Fruit(expiry: -4_000, name: .orange),
            Fruit(expiry: -6_000,  name: .orange),
        ]
        
        let sut = buildWarehouse(qualityAssuranceThreshold: 4_100, facilities: [
            Facility<Fruit>(capacity: 4),
            Facility<Meat>(capacity: 4),
        ])
        
        XCTAssertThrowsError(try sut.store(&goods)) { systemError in
            let error = systemError as! WarehouseError
            XCTAssertEqual(error.localizedDescription, WarehouseError.badGoods.localizedDescription)
        }
        
        self.warehouse = sut
    }
    
    func testUnsupportedFacility() throws {
        var goods: [Goods] = [
            Meat (expiry: 4_000,  name: .beaf),
        ]
        
        let sut = buildWarehouse(qualityAssuranceThreshold: 100, facilities: [
            Facility<Vegetable>(capacity: 4),
        ])
        
        XCTAssertThrowsError(try sut.store(&goods)) { systemError in
            let combinedError = systemError as! CombinedError
            let error = combinedError.errors[0] as! WarehouseError
            XCTAssertEqual(error.localizedDescription, WarehouseError.unsupportedFacility.localizedDescription)
        }
        
        XCTAssertThrowsError(
            try self.validateReport(
                of: Fruit.self,
                for: sut,
                count: 1,
                capacity: 10,
                filledPlaces: 3,
                isAtFullCapacity: false)
        ) { systemError in
            let error = systemError as! WarehouseError
            XCTAssertEqual(error.localizedDescription, WarehouseError.unsupportedFacility.localizedDescription)
        }
        
        self.warehouse = sut
    }
    
    func testFull() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        var goods: [Goods] = [
            Meat (expiry: 6_000,  name: .beaf),
            Meat (expiry: 9_000,  name: .beaf),
            
            Meat (expiry: 18_000, name: .fish),
            Meat (expiry: 7_000,  name: .fish),
            
            Fruit(expiry: 24_100,  name: .apple),
            Fruit(expiry: 25_000, name: .apple),
            Fruit(expiry: 44_200,  name: .apple),
            
            Fruit(expiry: 14_000, name: .orange),
            Fruit(expiry: 6_000,  name: .orange),
        ]
        
        let sut = buildWarehouse(qualityAssuranceThreshold: 4_100, facilities: [
            Facility<Fruit>(capacity: 2),
            Facility<Meat>(capacity: 2),
        ])
        
        XCTAssertThrowsError(try sut.store(&goods)) { systemError in
            let combinedError = systemError as! CombinedError
            combinedError.errors.forEach({ err in
                let error = err as! WarehouseError
                XCTAssertEqual(error.localizedDescription, WarehouseError.full.localizedDescription)
            })
            XCTAssertEqual(combinedError.errors.count, 5)
        }
        
        try validateReport(of: Fruit.self, for: sut,
                           count: 1,
                           capacity: 2,
                           filledPlaces: nil,
                           isAtFullCapacity: true)
        
        try validateReport(of: Meat.self, for: sut,
                           count: 1,
                           capacity: 2,
                           filledPlaces: nil,
                           isAtFullCapacity: true)
        
        self.warehouse = sut
    }
    
    private func validateReport<T: Goods>(
        of goods: T.Type,
        for warehouse: Warehouse,
        count: Int,
        capacity: Int,
        filledPlaces: Int?,
        isAtFullCapacity: Bool
    ) throws {
        let reports = try warehouse.collectReport(for: T.self)
        XCTAssertEqual(reports.count, count)
        let report = reports[count - 1]
        XCTAssertEqual(report.capacity, capacity)
        XCTAssertEqual(report.filledPlaces, filledPlaces)
        XCTAssertEqual(report.isAtFullCapacity, isAtFullCapacity)
    }
    
    private func buildWarehouse(qualityAssuranceThreshold: TimeInterval, facilities: [Storage]) -> Warehouse {
        
        let qualityAssurance = GoodsQualityAssurance(threshold: qualityAssuranceThreshold)
        let storageFacility = ColdStorage(repositories: facilities)
        let warehouse = Warehouse(qualityAssurance: qualityAssurance, storageFacility: storageFacility)
        return warehouse
    }
}
