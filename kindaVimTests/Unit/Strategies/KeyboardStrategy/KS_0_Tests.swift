@testable import kindaVim
import XCTest

class KS_0_Tests: KS_BaseTests {
    
    func test_that_0_is_getting_transformed_to_control_a() {
        let transformedKeys = keyboardStrategy.zero()

        guard transformedKeys.count == 1 else { return XCTFail() }
        XCTAssertEqual(transformedKeys[0].key, .a)
        XCTAssertEqual(transformedKeys[0].control, true)
        XCTAssertEqual(transformedKeys[0].action, .both)
    }
    
}

