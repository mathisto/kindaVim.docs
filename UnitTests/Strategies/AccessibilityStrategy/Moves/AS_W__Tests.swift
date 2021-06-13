@testable import kindaVim
import XCTest


// same as w
// we use a mock here because all the tests for this move
// are checked in the TextEngine function that this move called.
// rest is UI Tests to check that the globalColumnNumber is updated
class AS_W_Tests: AS_BaseTests {
    
    let textEngineMock = TextEngineMock()
    
    override func setUp() {
        super.setUp()
        
        accessibilityStrategy = AccessibilityStrategy(textEngine: textEngineMock)
    }    
    
}


// Both
extension AS_W_Tests {
    
    func test_that_it_calls_the_TextEngine_WORDForward_function() {
        let text = "should be calling WORDForward"
        let element = AccessibilityTextElement(
            role: .textField,
            value: text,
            caretLocation: 11,
            currentLine: AccessibilityTextElementLine(
                fullValue: text,
                number: 0,
                start: 0,
                end: 29
            )
        )
        
        _ = accessibilityStrategy.W(on: element)
        
        XCTAssertEqual(textEngineMock.functionCalled, "beginningOfWORDForward(startingAt:in:)")        
    }
    
}
