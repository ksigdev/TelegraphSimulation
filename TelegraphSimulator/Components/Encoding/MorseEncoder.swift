import Foundation

struct MorseEncoder: MessageEncoder {

    private let alphabet: [Character: String] = [
        "A": ".-",   "B": "-...", "C": "-.-.", "D": "-..",
        "E": ".",    "F": "..-.", "G": "--.",  "H": "....",
        "I": "..",   "J": ".---", "K": "-.-",  "L": ".-..",
        "M": "--",   "N": "-.",   "O": "---",  "P": ".--.",
        "Q": "--.-", "R": ".-.",  "S": "...",   "T": "-",
        "U": "..-",  "V": "...-", "W": ".--",  "X": "-..-",
        "Y": "-.--", "Z": "--..", " ": "/",
        "1": ".----", "2": "..---", "3": "...--", "4": "....-", "5": ".....",
        "6": "-....", "7": "--...", "8": "---..", "9": "----.", "0": "-----"
    ]
    
    private var reverseAlphabet: [String: Character] {
        return Dictionary(uniqueKeysWithValues: alphabet.map { ($1, $0) })
    }

    func encode(_ message: String) -> TelegraphData {
        return message.uppercased()
            .compactMap { alphabet[$0] } // Filtramos únicamente los símbolos válidos.
            .joined(separator: " ")
    }
    
    func decode(_ data: TelegraphData) -> String {
        let symbols = data.components(separatedBy: " ")
        let decodedChars = symbols.compactMap { reverseAlphabet[$0] }
        return String(decodedChars)
    }
}
