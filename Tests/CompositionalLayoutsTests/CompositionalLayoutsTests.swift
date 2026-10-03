import XCTest
#if canImport(UIKit)
import UIKit
@testable import CompositionalLayouts

final class CompositionalLayoutsTests: XCTestCase {
    @MainActor
    func testInstagramExploreLayoutCreation() {
        let layout = CompositionalLayoutFactory.makeInstagramExploreLayout()
        XCTAssertTrue(layout is UICollectionViewCompositionalLayout)
    }

    @MainActor
    func testCarouselShelfLayoutCreation() {
        let layout = CompositionalLayoutFactory.makeCarouselShelfLayout()
        XCTAssertTrue(layout is UICollectionViewCompositionalLayout)
    }

    @MainActor
    func testPhotoGridLayoutCreation() {
        let layout = CompositionalLayoutFactory.makePhotoGrid(columns: 4, spacing: 4)
        XCTAssertTrue(layout is UICollectionViewCompositionalLayout)
    }
}
#else
final class CompositionalLayoutsTests: XCTestCase {
    func testPlaceholder() {
        XCTAssertTrue(true)
    }
}
#endif
