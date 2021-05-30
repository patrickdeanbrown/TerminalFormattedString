# TerminalFormattedString

## Overview
`TerminalFormattedString` provides a lightweight, readable, and portable way to format and store 
formatted strings for output on a tty, such as the MacOS Terminal app. It uses ANSI escape sequences for applying
text color, background color, and text styles.

Specifying text formatting is straigtforward and familiar to those setting color properties in IDEs such as XCode,
and it should read like plain English.

```
    var formattedText = TerminalFormattedString("Hello, World!",
                                                textColor: .red,
                                                textBackground: .blue,
                                                textStyle: [.bold, .italic])
```



ANSI escape sequence data for Select Graphics Rendition (SGR) can be summarized as an integer, which make
`textColor`, `textBackground`, and `textStyle`, easily expressed through integer enums. Enums also allow XCode 
and other IDEs to provide a dropdown menu of options for `textColor`, `textBackground`, and `textStyle`. `textStyle`
is a `Set` and can contain multiple options, in order allow combined text styles such as bold and underlined text.

(The enum implementation comes from [ColorizeSwift](https://github.com/mtynior/ColorizeSwift), which extends the `String` builtin and is worth checking out.)

## Usage Examples

*Reusable Indicators*
`TerminalFormattedString` is useful for formatted text that is formatted once and reused. It also can be combined with string literals using the + operator.
```
var isJavascriptEnabled: Bool = false
var isJSONLibraryInstalled: Bool = true
var isServerConnected: Bool = true

var testPass = TerminalFormattedString("Pass",
                                        textColor: .green,
                                        textBackground: .black,
                                        textStyle: [.bold])

var testFail = TerminalFormattedString("Fail",
                                       textColor: .red,
                                       textBackground: .black,
                                       textStyle: [.bold])

print("[ " + (isJavascriptEnabled ? testPass : testFail) + " ]" + " JavaScript Enabled")
print("[ " + (isJSONLibraryInstalled ? testPass : testFail) + " ]" + " JSON Library Installed")
print("[ " + (isServerConnected ? testPass : testFail) + " ]" + " Connected to Remote Server")

```
![Pass Fail Output](Assets/pass_fail.png)

