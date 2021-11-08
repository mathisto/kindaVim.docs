@testable import kindaVim
import KeyCombination
import XCTest


class SucceedingASNM_ciRightBrace_Tests: SucceedingASNM_BaseTests {
    
    override func setUp() {
        super.setUp()
        
        kindaVimEngine.handle(keyCombination: KeyCombination(key: .c))
        kindaVimEngine.handle(keyCombination: KeyCombination(key: .i))
        kindaVimEngine.handle(keyCombination: KeyCombination(vimKey: .rightBrace))
    }
    
}


// see ci" for blah blah
extension SucceedingASNM_ciRightBrace_Tests {
    
    func test_that_it_calls_the_correct_function_on_accessibility_strategy() {
        XCTAssertEqual(asNormalModeMock.functionCalled, "ciRightBrace(on:)")
    }
    
}
