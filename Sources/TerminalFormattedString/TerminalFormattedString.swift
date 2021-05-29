//
//  TerminalFormattedString.swift
//
//  Created by Patrick Brown on 5/28/21.
//  
//

import Foundation

/// `TerminalFormattedString` stores and formats a `String` for output on a tty, such as the MacOS Terminal app. Text color, background color,
/// and text style are applied by dynamically appending ANSI escape codes to the raw string sent to the tty. For example, "Hello, world!" written in red text
/// is sent to the tty raw as "\u{001B}[38;5;9mHello, world!\u{001B}[0m".
public struct TerminalFormattedString: CustomStringConvertible, ExpressibleByStringLiteral, Equatable {
    public var rawText: String = ""
    public var textColor: TerminalColor?
    public var textBackground: TerminalColor?
    public var textStyle: Set<TerminalTextStyle>?
    
    /// Required  to conform to the `CustomStringConvertible` protocol.  `description` is used to provide the formatted
    /// string that is sent to the tty for interpretation.
    public var description: String {
        var formattedText = rawText
        
        if let c = textColor {
            formattedText = "\u{001B}[38;5;\(c.rawValue)m" + formattedText
        }
        
        if let b = textBackground {
            formattedText = "\u{001B}[48;5;\(b.rawValue)m" + formattedText
        }
        
        if let s = textStyle {
            for style in s {
                formattedText = "\u{001B}[\(style.rawValue)m" + formattedText
            }
        }
        
        // Add terminal clear escape sequence if formatted, otherwise returns rawText
        if textColor != nil || textBackground != nil || textStyle != nil {
            formattedText += "\u{001B}[0m"
        }
        
        return formattedText
    }
    
    public init(_ text: String, textColor: TerminalColor? = nil, textBackground: TerminalColor? = nil, textStyle: Set<TerminalTextStyle>? = nil) {
        self.rawText = text
        self.textColor = textColor
        self.textBackground = textBackground
        self.textStyle = textStyle
    }
    
    /// Required init function to conform to the `ExpressibleByStringLiteral` protocol
    ///
    /// Allows the following initialization of a `TerminalFormattedString` instance
    /// ```
    /// let myFormattedString: TerminalFormattedString = "Hi, there!"
    /// ```
    /// - Parameter stringLiteral: String to be formatted
    public init(stringLiteral text: String) {
        self.rawText = text
    }
    
    // Two + overloading functions were written so that TerminalFormattedString
    // would have the same behavior regardless of its position to strings in an
    // expression using +.
    public static func +(lhs: TerminalFormattedString, rhs: String) -> String {
        return lhs.description + rhs
    }
    
    public static func +(lhs: String, rhs: TerminalFormattedString) -> String {
        return lhs + rhs.description
    }
    
    /// Removes all formatting from the `TerminalFormattedString` instance
    public mutating func clearFormatting() {
        textColor = nil
        textBackground = nil
        textStyle = nil
    }
    
    /// Required to conform to the `Equatable` protocol. textStyle is a `Set`,  which returns `True` if both compared
    /// contain the same elements, in any order.
    public static func ==(lhs: TerminalFormattedString, rhs: TerminalFormattedString) -> Bool {
        return
            lhs.rawText == rhs.rawText &&
            lhs.textBackground == rhs.textBackground &&
            lhs.textColor == rhs.textColor &&
            lhs.textStyle == rhs.textStyle
    }
}

/// `TerminalColor` enum holds key data on ANSI escape commands for text and background colors.
///
/// The escape squences are text strings interpreted by the Terminal app or other tty. They are structured as "\u{001B}[",
/// the unicode for "ESC[", then the escape command number, and finally "m". An escape sequence indicating green text
/// would be "\u{001B}[38;5;3m". "38;5" indicates that a text color is being specified, and the "3" indicates that the text color
/// is green. The color names in `TerminalColor` were sourced from
/// https://jonasjacek.github.io/colors/
public enum TerminalColor: Int {
    case black = 0
    case maroon
    case green
    case olive
    case navy
    case purple
    case teal
    case silver
    case grey
    case red
    case lime
    case yellow
    case blue
    case fuchsia
    case aqua
    case white
    case grey0
    case navyBlue
    case darkBlue
    case blue3
    case blue3_2
    case blue1
    case darkGreen
    case deepSkyBlue4
    case deepSkyBlue4_2
    case deepSkyBlue4_3
    case dodgerBlue3
    case dodgerBlue2
    case green4
    case springGreen4
    case turquoise4
    case deepSkyBlue3
    case deepSkyBlue3_2
    case dodgerBlue1
    case green3
    case springGreen3
    case darkCyan
    case lightSeaGreen
    case deepSkyBlue2
    case deepSkyBlue1
    case green3_2
    case springGreen3_2
    case springGreen2
    case cyan3
    case darkTurquoise
    case turquoise2
    case green1
    case springGreen2_2
    case springGreen1
    case mediumSpringGreen
    case cyan2
    case cyan1
    case darkRed
    case deepPink4
    case purple4
    case purple4_2
    case purple3
    case blueViolet
    case orange4
    case grey37
    case mediumPurple4
    case slateBlue3
    case slateBlue3_2
    case royalBlue1
    case chartreuse4
    case darkSeaGreen4
    case paleTurquoise4
    case steelBlue
    case steelBlue3
    case cornflowerBlue
    case chartreuse3
    case darkSeaGreen4_2
    case cadetBlue
    case cadetBlue_2
    case skyBlue3
    case steelBlue1
    case chartreuse3_2
    case paleGreen3
    case seaGreen3
    case aquamarine3
    case mediumTurquoise
    case steelBlue1_2
    case chartreuse2
    case seaGreen2
    case seaGreen1
    case seaGreen1_2
    case aquamarine1
    case darkSlateGray2
    case darkRed_2
    case deepPink4_2
    case darkMagenta
    case darkMagenta_2
    case darkViolet
    case purple_2
    case orange4_2
    case lightPink4
    case plum4
    case mediumPurple3
    case mediumPurple3_2
    case slateBlue1
    case yellow4
    case wheat4
    case grey53
    case lightSlateGrey
    case mediumPurple
    case lightSlateBlue
    case yellow4_2
    case darkOliveGreen3
    case darkSeaGreen
    case lightSkyBlue3
    case lightSkyBlue3_2
    case skyBlue2
    case chartreuse2_2
    case darkOliveGreen3_2
    case paleGreen3_2
    case darkSeaGreen3
    case darkSlateGray3
    case skyBlue1
    case chartreuse1
    case lightGreen
    case lightGreen_2
    case paleGreen1
    case aquamarine1_2
    case darkSlateGray1
    case red3
    case deepPink4_3
    case mediumVioletRed
    case magenta3
    case darkViolet_2
    case purple_3
    case darkOrange3
    case indianRed
    case hotPink3
    case mediumOrchid3
    case mediumOrchid
    case mediumPurple2
    case darkGoldenrod
    case lightSalmon3
    case rosyBrown
    case grey63
    case mediumPurple2_2
    case mediumPurple1
    case gold3
    case darkKhaki
    case navajoWhite3
    case grey69
    case lightSteelBlue3
    case lightSteelBlue
    case yellow3
    case darkOliveGreen3_3
    case darkSeaGreen3_2
    case darkSeaGreen2
    case lightCyan3
    case lightSkyBlue1
    case greenYellow
    case darkOliveGreen2
    case paleGreen1_2
    case darkSeaGreen2_2
    case darkSeaGreen1
    case paleTurquoise1
    case red3_2
    case deepPink3
    case deepPink3_2
    case magenta3_2
    case magenta3_3
    case magenta2
    case darkOrange3_2
    case indianRed_2
    case hotPink3_2
    case hotPink2
    case orchid
    case mediumOrchid1
    case orange3
    case lightSalmon3_2
    case lightPink3
    case pink3
    case plum3
    case violet
    case gold3_2
    case lightGoldenrod3
    case tan
    case mistyRose3
    case thistle3
    case plum2
    case yellow3_2
    case khaki3
    case lightGoldenrod2
    case lightYellow3
    case grey84
    case lightSteelBlue1
    case yellow2
    case darkOliveGreen1
    case darkOliveGreen1_2
    case darkSeaGreen1_2
    case honeydew2
    case lightCyan1
    case red1
    case deepPink2
    case deepPink1
    case deepPink1_2
    case magenta2_2
    case magenta1
    case orangeRed1
    case indianRed1
    case indianRed1_2
    case hotPink
    case hotPink_2
    case mediumOrchid1_2
    case darkOrange
    case salmon1
    case lightCoral
    case paleVioletRed1
    case orchid2
    case orchid1
    case orange1
    case sandyBrown
    case lightSalmon1
    case lightPink1
    case pink1
    case plum1
    case gold1
    case lightGoldenrod2_2
    case lightGoldenrod2_3
    case navajoWhite1
    case mistyRose1
    case thistle1
    case yellow1
    case lightGoldenrod1
    case khaki1
    case wheat1
    case cornsilk1
    case grey100
    case grey3
    case grey7
    case grey11
    case grey15
    case grey19
    case grey23
    case grey27
    case grey30
    case grey35
    case grey39
    case grey42
    case grey46
    case grey50
    case grey54
    case grey58
    case grey62
    case grey66
    case grey70
    case grey74
    case grey78
    case grey82
    case grey85
    case grey89
    case grey93
}

/// `TerminalTextStyle` enum holds key data on ANSI escape commands for text style.
///
/// The escape squences are text strings interpreted by the Terminal app or other tty. They are structured
/// as "\u{001B}[", the unicode for "ESC[", then the escape command number, and finally "m". An escape
/// sequence indicating bold text would be "\u{001B}[1m".
public enum TerminalTextStyle: Int {
    case bold = 1
    case dim
    case italic
    case underline
    case blink
    case reverse
    case hidden
    case strikethrough
}

