//
//  Util.swift
//  ExampleIndexedScrollView
//
//  Created by 이소정 on 2023/08/24.
//

import Foundation

// MARK: 한글 초성 분해 관련 로직

extension String {
    var trimmingWhiteSpace: String {
        let scalars = self.unicodeScalars.filter {
            !CharacterSet.whitespacesAndNewlines.contains($0)
        }
        return String(scalars)
    }
    
    /// 첫번째 자모음을 분해 해서 return.
    var firstJamo: String {
        let scalar = self.unicodeScalars.first
        
        guard let scalar = scalar else {
            return String()
        }
        
        let result = getJamoFromOneSyllable(scalar).first ?? " "
        
        return String(result)
    }
    
    /// 공백 제거 및 한글일 경우 자모음 분해.
    var disassembled: String {
        var jamo = String()
        for scalar in self.unicodeScalars{
            // 공백은 무시
            if CharacterSet.whitespacesAndNewlines.contains(scalar) {
                continue
            }
                
            jamo += getJamoFromOneSyllable(scalar)
        }
        return jamo
    }
    
    var disassembledChosung: String {
        var result = String()
        
        for scalar in self.unicodeScalars{
            // 공백은 무시
            if CharacterSet.whitespacesAndNewlines.contains(scalar) {
                continue
            }
                
            if CharacterSet.hangul.contains(scalar) {
                // 한글 index
                let index = scalar.value - String.hangulStartIndex
                
                // 초성, 중성, 종성 분리
                // 종성 = 완성형 % 28
                let chosung: String = String.chosungList[Int(index / String.chosungCycle)]
                result += chosung
            }
        }
        return result
    }
    
    static func assembled(chosung: String, jungsung: String, jongsung: String? = nil) -> UnicodeScalar? {
        let defaultJongsung = 0
        guard !chosung.isEmpty && !jungsung.isEmpty else { return nil }
        
        let chosungIdx: Int? = String.chosungList.firstIndex { $0 == chosung }
        let jungsungIdx: Int? = String.jungsungList.firstIndex { $0 == jungsung }
        let jongsungIdx: Int = String.jongsungList.firstIndex { $0 == jongsung } ?? defaultJongsung
        
        guard let chosungIdx = chosungIdx else {
            return nil
        }
        
        guard let jungsungIdx = jungsungIdx else {
            return nil
        }
        
        let result = ((((UInt32(chosungIdx) * chosungNumber) + UInt32(jungsungIdx)) * jungsungCycle) + UInt32(jongsungIdx)) + hangulStartIndex
        
        return UnicodeScalar(result)
    }
    
    // UTF-8 기준
    static let hangulStartIndex: UInt32 = 44032  // "가"
    static let hangulEndIndex:UInt32 = 55199    // "힣"
    
    static let chosungCycle: UInt32 = 588
    static let jungsungCycle: UInt32 = 28
    static let chosungNumber: UInt32 = 21
    
    static let chosungList: [String] = [
        "ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ",
        "ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"
    ]
    
    static let jungsungList: [String] = [
        "ㅏ", "ㅐ", "ㅑ", "ㅒ", "ㅓ", "ㅔ","ㅕ", "ㅖ", "ㅗ", "ㅘ",
        "ㅙ", "ㅚ","ㅛ", "ㅜ", "ㅝ", "ㅞ", "ㅟ", "ㅠ", "ㅡ", "ㅢ",
        "ㅣ"
    ]
    
    static let jongsungList: [String] = [
        "","ㄱ","ㄲ","ㄳ","ㄴ","ㄵ","ㄶ","ㄷ","ㄹ","ㄺ",
        "ㄻ","ㄼ","ㄽ","ㄾ","ㄿ","ㅀ","ㅁ","ㅂ","ㅄ","ㅅ",
        "ㅆ","ㅇ","ㅈ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"
    ]
    
    static let doubleJongsungDictionary: [String: String] = [
        "ㄳ":"ㄱㅅ", "ㄵ":"ㄴㅈ", "ㄶ":"ㄴㅎ", "ㄺ":"ㄹㄱ", "ㄻ":"ㄹㅁ",
        "ㄼ":"ㄹㅂ", "ㄽ":"ㄹㅅ", "ㄾ":"ㄹㅌ", "ㄿ":"ㄹㅍ", "ㅀ":"ㄹㅎ",
        "ㅄ":"ㅂㅅ"
    ]
    
    // 주어진 "코드의 음절"을 자모음으로 분해해서 리턴하는 함수
    private func getJamoFromOneSyllable(_ char: UnicodeScalar) -> String {
        // 조합형 한글일 경우 ex) ㄱ, ㄴ, ...ㅣ
        if CharacterSet.combinatedHangul.contains(char) {
            return String(char)
        }
        // 완성형 한글일 경우
        else if CharacterSet.completedHangul.contains(char){
            // 한글 index
            let index = char.value - String.hangulStartIndex
            
            // 초성, 중성, 종성 분리
            // 종성 = 완성형 % 28
            // 중성 = ((완성형 - 종성) / 28) % 21
            // 초성 = (((완성형 - 종성) / 28) - 중성) / 21
            let chosung: String = String.chosungList[Int(index / String.chosungCycle)]
            let jungsung: String =
                String.jungsungList[Int((index % String.chosungCycle) / String.jungsungCycle)]
            let jongsung: String = String.jongsungList[Int(index % String.jungsungCycle)]
            // 종성(받침)이 이중 자음인 경우 두개의 자음으로 분리
//            if let disassembledJongsung = String.doubleJongsungDictionary[jongsung] {
//                jongsung = disassembledJongsung
//            }
            return chosung + jungsung + jongsung
        } else { // 한글이 아닐경우(영어, 숫자 등등...)
            return String(UnicodeScalar(char))
        }
    }
    
    static func getJamoFromOneSyllable(_ scalar: UnicodeScalar) -> (chosung: String, jungsung: String, jongSung: String)? {
        // 한글일 경우
        if CharacterSet.hangul.contains(scalar){
            // 한글 index
            let index = scalar.value - String.hangulStartIndex
            
            // 초성, 중성, 종성 분리
            // 종성 = 완성형 % 28
            // 중성 = ((완성형 - 종성) / 28) % 21
            // 초성 = (((완성형 - 종성) / 28) - 중성) / 21
            let chosung: String = String.chosungList[Int(index / String.chosungCycle)]
            let jungsung: String =
                String.jungsungList[Int((index % String.chosungCycle) / String.jungsungCycle)]
            let jongsung: String = String.jongsungList[Int(index % String.jungsungCycle)]
            return (chosung, jungsung, jongsung)
        } else { // 한글이 아닐경우(영어, 숫자 등등...)
            return nil
        }
    }
    
}

extension CharacterSet {
    // 모든 한글
    static let hangul: CharacterSet =
        completedHangul.union(combinatedHangul)
    
    // 완성형 한글
    static let completedHangul: CharacterSet =
        CharacterSet(charactersIn: ("가".unicodeScalars.first!)...("힣".unicodeScalars.first!))
    
    // 조합형 한글
    static let combinatedHangul: CharacterSet =
        CharacterSet(charactersIn: ("ㄱ".unicodeScalars.first!)...("ㅣ".unicodeScalars.first!))
    
    // 특정 문자로부터 범위를 return
    // 문자의 scalar 값을 구하지 못할 경우 nil return.
    // ex) ㄱ -> ㄱ,가,각...깋 / 나 -> 나,낙...닣 / ❤️ -> nil
    static func range(from char: Character) -> CharacterSet? {
        let word: String = char.toString

        guard let scalar = word.unicodeScalars.first else {
            debugPrint("[CharacterSet+Hangul] \(char) 는 scalar 로 변환할 수 없습니다.")
            return nil
        }

        // 한글일 때
        if hangul.contains(scalar) {
            // 조합형일 때 (ex. ㄱ / ㅏ)
            if combinatedHangul.contains(scalar) {
                return range(fromCombinated: scalar)
            }
            // 완성형일 때
            else {
                return range(fromCompleted: scalar)
            }

        } else { // 한글이 아닐 때
            return CharacterSet(charactersIn: scalar...scalar)
        }
    }

    // 특정문자가 조합형일 때 범위를 return
    static private func range(fromCombinated scalar: UnicodeScalar) -> CharacterSet? {
        let letter: String = Character(scalar).toString
        
        // 초성일때
        if String.chosungList.contains(letter) {
            let firstInRange: UnicodeScalar? = String.assembled(chosung: letter, jungsung: "ㅏ")
            let lastInRange: UnicodeScalar? = String.assembled(chosung: letter, jungsung: "ㅣ", jongsung: "ㅎ")
            
            guard let firstInRange = firstInRange, let lastInRange = lastInRange else {
                return nil
            }
            
            let combinatedSet: CharacterSet = CharacterSet(charactersIn: scalar...scalar)
            let completedSet: CharacterSet = CharacterSet(charactersIn: firstInRange...lastInRange)
            
            return combinatedSet.union(completedSet)
        }
        
        // 아닐때 (ex. ㅏ / ㄳ ...)
        else {
            return CharacterSet(charactersIn: scalar...scalar)
        }
    }
    
    // 특정문자가 완성형일때 범위를 return
    static private func range(fromCompleted scalar: UnicodeScalar) -> CharacterSet? {
        let disassembled = String.getJamoFromOneSyllable(scalar)
        
        guard let disassembled = disassembled else {
            return nil
        }
        
        let chosung: String = disassembled.chosung
        let jungsung: String = disassembled.jungsung
        let jongsung: String = disassembled.jongSung
        
        // 초성 + 중성 일때
        if disassembled.jongSung.isEmpty {
            let firstInRange: UnicodeScalar? = String.assembled(chosung: chosung, jungsung: jungsung)
            let lastInRange: UnicodeScalar? = String.assembled(chosung: chosung, jungsung: jungsung, jongsung: "ㅎ")
            
            guard let firstInRange = firstInRange, let lastInRange = lastInRange else {
                return nil
            }
            
            return CharacterSet(charactersIn: firstInRange...lastInRange)
        }
        // 초성 + 중성 + 종성 일때
        else {
            let assembled: UnicodeScalar? = String.assembled(chosung: chosung, jungsung: jungsung, jongsung: jongsung)
            
            guard let assembled = assembled else {
                return nil
            }
            
            return CharacterSet(charactersIn: assembled...assembled)
        }
    }
}

extension Character {
    var toString: String {
        return String([self])
    }
}
