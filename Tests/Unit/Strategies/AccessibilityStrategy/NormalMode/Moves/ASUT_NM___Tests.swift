@testable import kindaVim
import XCTest


// two things here:
// 1) the _ move is currently a copy of the ^ move, as we're not handling counts
// 2) as ^, this is using mainly the TextEngine.firstNonBlank function that is already 
// heavily tested
// so basically this is just a copy paste from ^. if one day we implement the counts, then
// we'll have to update accordingly
class ASNM___Tests: ASNM_BaseTests {
    
    private func applyMove(on element: AccessibilityTextElement?) -> AccessibilityTextElement? {
        return asNormalMode.underscore(on: element) 
    }
    
}


// Both
extension ASNM___Tests {
    
    func test_that_in_normal_case_it_goes_to_the_first_non_blank_of_the_line() {
        let text = "    hehe ankulay"
        let element = AccessibilityTextElement(
            role: .textField,
            value: text,
            length: 16,
            caretLocation: 2,
            selectedLength: 1,
            selectedText: " ",
            currentLine: AccessibilityTextElementLine(
                fullValue: text,
                number: 1,
                start: 0,
                end: 16
            )
        )
        
        let returnedElement = applyMove(on: element)
        
        XCTAssertEqual(returnedElement?.caretLocation, 4)
        XCTAssertEqual(returnedElement?.selectedLength, 1)
        XCTAssertNil(returnedElement?.selectedText)
    }
    
    func test_that_if_the_text_is_just_spaces_and_no_linefeed_then_the___goes_at_the_end_of_the_text() {
        let text = """
a multiline
with a last line
without a linefeed but with spaces
                      
"""
        let element = AccessibilityTextElement(
            role: .textArea,
            value: text,
            length: 86,
            caretLocation: 71,
            selectedLength: 1,
            selectedText: " ",
            currentLine: AccessibilityTextElementLine(
                fullValue: text,
                number: 4,
                start: 64,
                end: 86
            )
        )
        
        let returnedElement = applyMove(on: element)
        
        XCTAssertEqual(returnedElement?.caretLocation, 85)    
        XCTAssertEqual(returnedElement?.selectedLength, 1)
        XCTAssertNil(returnedElement?.selectedText)
    }
    
}


// TextViews 
extension ASNM___Tests {
    
    func test_that_for_spaces_and_a_linefeed_it_stops_before_the_linefeed_at_the_correct_end_limit() {
        let text = """
this time the
empty line has a linefeed
                      
 yes
"""
        let element = AccessibilityTextElement(
            role: .textArea,
            value: text,
            length: 67,
            caretLocation: 44,
            selectedLength: 1,
            selectedText: " ",
            currentLine: AccessibilityTextElementLine(
                fullValue: text,
                number: 3,
                start: 40,
                end: 63
            )
        )
        
        let returnedElement = applyMove(on: element)
        
        XCTAssertEqual(returnedElement?.caretLocation, 61)
        XCTAssertEqual(returnedElement?.selectedLength, 1)
        XCTAssertNil(returnedElement?.selectedText)
    }
    
}