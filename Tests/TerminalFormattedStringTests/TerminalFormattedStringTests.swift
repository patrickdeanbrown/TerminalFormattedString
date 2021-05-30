@testable import TerminalFormattedString
import XCTest

final class TerminalFormattedStringTests: XCTestCase {
    func testTerminalTextColorEnumForText() {
        var numericCaseRepresentation: Int = 0
        var formattedText = TerminalFormattedString("TEXT",
                                                    textColor: nil,
                                                    textBackground: nil,
                                                    textStyle: [])
            
        for textColorCase in TerminalColor.allCases {
            formattedText.textColor = textColorCase
            XCTAssertEqual(formattedText.description,
                           "\u{001B}[38;5;\(numericCaseRepresentation)mTEXT\u{001B}[0m",
                           "Text color failed at case: \(textColorCase.rawValue).")
                
            numericCaseRepresentation += 1
        }
    }
        
    func testTerminalColorEnumForBackground() {
        var numericCaseRepresentation: Int = 0
        var formattedText = TerminalFormattedString("TEXT",
                                                    textColor: nil,
                                                    textBackground: nil,
                                                    textStyle: [])
            
        for backgroundColorCase in TerminalColor.allCases {
            formattedText.textBackground = backgroundColorCase
            XCTAssertEqual(formattedText.description,
                           "\u{001B}[48;5;\(numericCaseRepresentation)mTEXT\u{001B}[0m",
                           "Text background failed at case: \(backgroundColorCase.rawValue).")
                
            numericCaseRepresentation += 1
        }
    }
        
    // Color support maxes out at 256 colors using ANSI escape sequences
    func totalTerminalColors() {
        XCTAssertTrue(TerminalColor.allCases.count == 256)
    }

    // Because the order of a set is uncertain, the output order of ANSI
    // escape codes is also uncertain. Test focuses on equatability of
    // values in set.
    func testTerminalTextStyleEnum() {
        var formattedTextFirst = TerminalFormattedString("TEXT",
                                                         textColor: nil,
                                                         textBackground: nil,
                                                         textStyle: [])
            
        var formattedTextSecond = TerminalFormattedString("TEXT",
                                                          textColor: nil,
                                                          textBackground: nil,
                                                          textStyle: [])
            
        for style in TerminalTextStyle.allCases {
            formattedTextFirst.textStyle.insert(style)
            formattedTextSecond.textStyle.insert(style)
            XCTAssertEqual(formattedTextFirst, formattedTextSecond)
        }
    }
    
}
