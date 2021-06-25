@testable import kindaVim
import XCTest


class ASVM_h_Tests: ASVM_BaseTests {
    
    private func applyMove(on element: AccessibilityTextElement?) -> AccessibilityTextElement? {
        return asVisualMode.h(on: element) 
    }
    
}


// the 3 special cases:
// - empty TextElement
// - caret at the end of TextElement but not on empty line
// - caret at the end of TextElement on own empty line
extension ASVM_h_Tests {
    
    func test_that_if_the_TextElement_is_empty_it_does_nothing_and_does_not_crash() {
        let text = ""
        let element = AccessibilityTextElement(
            role: .textField,
            value: text,
            caretLocation: 0,
            currentLine: AccessibilityTextElementLine(
                fullValue: text,
                number: nil,
                start: nil,
                end: nil
            )
        )
        
        let returnedElement = applyMove(on: element)
        
        XCTAssertEqual(returnedElement?.caretLocation, 0)
        XCTAssertEqual(returnedElement?.selectedLength, 0)
        XCTAssertNil(returnedElement?.selectedText)
    }
    
    func test_that_if_the_caret_is_at_the_last_character_of_the_TextElement_but_not_on_an_empty_line_it_goes_back_one_character_and_selects_it() {
        let text = """
caret is
gonna be at the end
"""
        let element = AccessibilityTextElement(
            role: .textArea,
            value: text,
            caretLocation: 28,
            currentLine: AccessibilityTextElementLine(
                fullValue: text,
                number: nil,
                start: nil,
                end: nil
            )
        )
        
        let returnedElement = applyMove(on: element)
        
        XCTAssertEqual(returnedElement?.caretLocation, 27)
        XCTAssertEqual(returnedElement?.selectedLength, 1)
        XCTAssertNil(returnedElement?.selectedText)
    }
    
    func test_that_if_the_caret_is_at_the_last_character_of_the_TextElement_and_on_an_empty_line_it_does_nothing_and_does_not_crash() {
        let text = """
caret is on its
own empty
line

"""
        let element = AccessibilityTextElement(
            role: .textArea,
            value: text,
            caretLocation: 31,
            currentLine: AccessibilityTextElementLine(
                fullValue: text,
                number: nil,
                start: nil,
                end: nil
            )
        )
        
        let returnedElement = applyMove(on: element)
        
        XCTAssertEqual(returnedElement?.caretLocation, 31)
        XCTAssertEqual(returnedElement?.selectedLength, 0)
        XCTAssertNil(returnedElement?.selectedText)
    }
    
}


// Both
extension ASVM_h_Tests {
    
    func test_that_in_normal_setting_it_unselects_one_more_character_to_the_left() {
        let text = "well how can we test the selectedLength?..."
        let element = AccessibilityTextElement(
            role: .textField,
            value: text,
            caretLocation: 22,
            selectedLength: 4,
            currentLine: AccessibilityTextElementLine(
                fullValue: text,
                number: 0,
                start: 0,
                end: 43
            )
        )
        
        // first we need to call v in order to set VM head and anchor, like in real life
        // then we need to update the selectLength so that head and anchor get updated with
        // correct values through the didSet.
        // may be better to run this through UI Tests but too slow already :p
        var elementAfterVisualModeCharacterwiseOn = asVisualMode.v(on: element)
        elementAfterVisualModeCharacterwiseOn?.selectedLength = 4
        let returnedElement = applyMove(on: elementAfterVisualModeCharacterwiseOn) 
        
        XCTAssertEqual(returnedElement?.caretLocation, 22)
        XCTAssertEqual(returnedElement?.selectedLength, 3)        
    }
    
    func test_that_if_the_caret_is_at_the_start_of_the_line_and_the_selection_is_more_than_one_it_can_still_moves_and_reduce_the_selection() {
        let text = """
yeah
that's kinda weird when
it bugs
"""
        let element = AccessibilityTextElement(
            role: .textArea,
            value: text,
            caretLocation: 5,
            currentLine: AccessibilityTextElementLine(
                fullValue: text,
                number: 1,
                start: 5,
                end: 29
            )
        )
                   
        var elementAfterVisualModeCharacterwiseOn = asVisualMode.v(on: element)
        elementAfterVisualModeCharacterwiseOn?.selectedLength = 5
        let returnedElement = applyMove(on: elementAfterVisualModeCharacterwiseOn)        
        
        XCTAssertEqual(returnedElement?.caretLocation, 5)
        XCTAssertEqual(returnedElement?.selectedLength, 4)
    }
    
}
