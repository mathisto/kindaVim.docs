@testable import kindaVim
import KeyCombination
import XCTest


class EnforcingKSVM_k_Tests: EnforcingKSVM_BaseTests {
    
    private func applyKeyCombinationBeingTested() {
        kindaVimEngine.handle(keyCombination: KeyCombination(vimKey: .k), enforceKeyboardStrategy: true)
    }

}


// VisualStyle Characterwise
extension EnforcingKSVM_k_Tests {

    func test_that_it_calls_the_correct_function_on_KS_when_in_VisualStyle_Characterwise() {
        kindaVimEngine.visualStyle = .characterwise
        applyKeyCombinationBeingTested()
        
        XCTAssertEqual(ksVisualModeMock.functionCalled, "kForVisualStyleCharacterwise()")
    }

}


// VisualStyle Linewise
extension EnforcingKSVM_k_Tests {

    func test_that_it_calls_the_correct_function_on_KS_when_in_VisualStyle_Linewise() {
        kindaVimEngine.visualStyle = .linewise
        applyKeyCombinationBeingTested()
        
        XCTAssertEqual(ksVisualModeMock.functionCalled, "kForVisualStyleLinewise()")
    }

}


// Both
extension EnforcingKSVM_k_Tests {
    
    func test_that_it_keeps_Vim_in_visual_mode() {
        applyKeyCombinationBeingTested()
        
        XCTAssertEqual(kindaVimEngine.currentMode, .visual)
    }
    
}
