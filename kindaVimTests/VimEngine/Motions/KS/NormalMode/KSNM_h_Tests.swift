@testable import kindaVim
import KeyCombination
import XCTest


class KSNM_h_Tests: KSNM_BaseTests {

    override func setUp() {
        super.setUp()

        kindaVimEngine.handle(keyCombination: KeyCombination(vimKey: .eight))
        kindaVimEngine.handle(keyCombination: KeyCombination(key: .h))
    }

}


extension KSNM_h_Tests {
    
    func test_that_h_calls_the_h_function_on_keyboard_strategy() {
        XCTAssertEqual(ksNormalModeMock.functionCalled, "h()")
    }
    
    func test_that_h_keeps_Vim_in_normal_mode() {
        XCTAssertEqual(kindaVimEngine.state.currentMode, .normal)
    }
        
    func test_that_it_resets_the_count() {
        XCTAssertNil(kindaVimEngine.count)
    }

}
