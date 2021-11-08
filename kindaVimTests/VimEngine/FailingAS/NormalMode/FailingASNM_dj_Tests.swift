@testable import kindaVim
import KeyCombination
import XCTest


class FailingASNM_dj_Tests: FailingAS_BaseTests {
    
    private func applyMoveBeingTested() {
        kindaVimEngine.handle(keyCombination: KeyCombination(key: .d))
        kindaVimEngine.handle(keyCombination: KeyCombination(key: .j))
    }

}


extension FailingASNM_dj_Tests {
    
    func test_that_the_move_calls_the_correct_function_for_TextElements_on_KS() {
        kindaVimEngine.axEngine = AXEngineTextElementMock()
        applyMoveBeingTested()

        XCTAssertEqual(ksNormalModeMock.functionCalled, "djForTextElement()")
    }
    
    func test_that_the_move_calls_the_correct_function_for_NonTextElements_on_KS() {
        kindaVimEngine.axEngine = AXEngineNonTextElementMock()
        applyMoveBeingTested()

        XCTAssertEqual(ksNormalModeMock.functionCalled, "djForNonTextElement()")
    }
    
    func test_that_dj_keeps_Vim_in_normal_mode() {
        applyMoveBeingTested()
        
        XCTAssertEqual(kindaVimEngine.currentMode, .normal)
    }
   
}
