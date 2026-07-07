import XCTest
@testable import Comicbox

@MainActor
final class ComicboxTests: XCTestCase {
    var store: Store!

    override func setUp() {
        super.setUp()
        store = Store()
        store.items = []
    }

    func testSeedDataStaysUnderFreeLimit() {
        XCTAssertLessThan(Store.seedData.count, Store.freeLimit)
    }

    func testAddItem() {
        store.add(name: "Test Issue", series: "Amazing Spider-Man", grade: "9.4")
        XCTAssertEqual(store.items.count, 1)
        XCTAssertEqual(store.items.first?.name, "Test Issue")
    }

    func testCanAddBelowLimit() {
        XCTAssertTrue(store.canAdd())
    }

    func testFreeLimitBlocksAdd() {
        for i in 0..<Store.freeLimit {
            store.add(name: "Item \(i)", series: "Amazing Spider-Man", grade: "9.4")
        }
        XCTAssertFalse(store.canAdd())
        XCTAssertTrue(store.isAtFreeLimit)
    }

    func testProBypassesLimit() {
        store.isPro = true
        for i in 0..<(Store.freeLimit + 5) {
            store.add(name: "Item \(i)", series: "Amazing Spider-Man", grade: "9.4")
        }
        XCTAssertTrue(store.canAdd())
    }

    func testDeleteItem() {
        store.add(name: "ToDelete", series: "Amazing Spider-Man", grade: "9.4")
        let item = store.items[0]
        store.delete(item)
        XCTAssertEqual(store.items.count, 0)
    }

    func testUpdateItem() {
        store.add(name: "Original", series: "Amazing Spider-Man", grade: "9.4")
        var item = store.items[0]
        item.name = "Updated"
        store.update(item)
        XCTAssertEqual(store.items.first?.name, "Updated")
    }

    func testDeleteAtOffsets() {
        store.add(name: "A", series: "Amazing Spider-Man", grade: "9.4")
        store.add(name: "B", series: "Amazing Spider-Man", grade: "9.4")
        store.delete(at: IndexSet(integer: 0))
        XCTAssertEqual(store.items.count, 1)
        XCTAssertEqual(store.items.first?.name, "B")
    }
}
