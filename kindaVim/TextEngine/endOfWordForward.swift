extension TextEngine {
    
    func endOfWordForward(startingAt location: Int, in text: TextEngineText) -> Int {
        let value = text.value
        
        guard let anchorIndex = value.index(value.startIndex, offsetBy: location + 1, limitedBy: value.endIndex) else { return text.endLimit }
        let endIndex = value.endIndex
        
        for index in value[anchorIndex..<endIndex].indices {
            guard index != value.index(before: endIndex) else { return text.endLimit }
            let nextIndex = value.index(after: index)
            
            if value[index].isCharacterThatConstitutesAVimWord {
                if value[nextIndex].isCharacterThatConstitutesAVimWord {
                    continue
                }
            }
            
            if value[index].isPunctuationButNotUnderscore {
                if value[nextIndex].isPunctuationButNotUnderscore || value[nextIndex].isSymbol {
                    continue
                }
            }
            
            if value[index].isSymbol {
                if value[nextIndex].isSymbol {
                    continue
                }
            }
            
            if value[index].isWhitespaceButNotNewline {
                if value[nextIndex].isWhitespace || value[nextIndex].isCharacterThatConstitutesAVimWord || value[nextIndex].isPunctuationButNotUnderscore || value[nextIndex].isSymbol {
                    continue
                }
            }
            
            if value[index].isNewline {
                continue
            }
            
            return value.distance(from: value.startIndex, to: index)
        }
        
        return location
    }
    
}
