extension AccessibilityStrategyVisualMode {
    
    func d(on element: AccessibilityTextElement?) -> AccessibilityTextElement? {
        guard var element = element else { return nil }
        
        if element.isEmpty {
            return element
        }
        
        if element.caretIsAtTheEnd, element.lastCharacterIsNotLinefeed {
            return element
        }
        
        if element.caretIsAtTheEnd, element.lastCharacterIsLinefeed {
            return element
        }
        
        
        element.selectedText = ""
        
        
        if VimEngine.shared.visualStyle == .linewise {
            if let axNextLine = AXEngine.axLineRangeFor(lineNumber: element.currentLine.number! + 1) {
                let value = element.value
                let axNextLineText = String(value[value.index(value.startIndex, offsetBy: axNextLine.location)..<value.index(value.startIndex, offsetBy: axNextLine.location + axNextLine.length)])
                let firstNonBlankOfNextLineLocation = textEngine.firstNonBlank(in: axNextLineText)
                let firstNonBlankOfNextLineText = axNextLineText[..<axNextLineText.index(axNextLineText.startIndex, offsetBy: firstNonBlankOfNextLineLocation)]
            
                _ = AccessibilityTextElementAdaptor.toAXfocusedElement(from: element)
                
                element.caretLocation += firstNonBlankOfNextLineText.count
                element.selectedLength = 0
                element.selectedText = nil
            }                
        }
        
        return element
    }
    
}
