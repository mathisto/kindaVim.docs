import KeyCombination


protocol CommandLineModeProtocol {
    
    func q() -> [KeyCombination]
    func w() -> [KeyCombination]
    func wq() -> [KeyCombination]
    
}


struct CommandLineMode: CommandLineModeProtocol {

    func q() -> [KeyCombination] {
        return [
            KeyCombination(key: .q, command: true)
        ]
    }
        
    func w() -> [KeyCombination] {
        return [
            KeyCombination(key: .s, command: true)
        ]
    }
    
    func wq() -> [KeyCombination] {
        return [
            KeyCombination(key: .s, command: true),
            KeyCombination(key: .q, command: true)
        ]
    }
    
}
