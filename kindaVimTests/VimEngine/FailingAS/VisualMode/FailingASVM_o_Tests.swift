@testable import kindaVim
import KeyCombination
import XCTest


class FailingASVM_o_Tests: FailingASVM_BaseTests {
    
    private func applyKeyCombinationBeingTested() {
        kindaVimEngine.handle(keyCombination: KeyCombination(key: .o))
    }
    
}


// VisualStyle Characterwise
extension FailingASVM_o_Tests {
    
    func test_that_it_does_not_calls_any_KS_function_because_this_move_is_not_YET_implemented() {
        kindaVimEngine.visualStyle = .characterwise
        applyKeyCombinationBeingTested()
        
        XCTAssertEqual(ksVisualModeMock.functionCalled, "")
    }
    
}


// VisualStyle Linewise
extension FailingASVM_o_Tests {
    
    func test_that_it_does_not_calls_any_KS_function_because_this_move_does_not_exist_for_VisualStyle_Linewise() {
        kindaVimEngine.visualStyle = .linewise
        applyKeyCombinationBeingTested()
        
        XCTAssertEqual(ksVisualModeMock.functionCalled, "")
    }
    
}


// Both
extension FailingASVM_o_Tests {
    
    func test_that_it_keeps_Vim_in_visual_mode() {
        applyKeyCombinationBeingTested()
        
        XCTAssertEqual(kindaVimEngine.currentMode, .visual)
    }
        
}

