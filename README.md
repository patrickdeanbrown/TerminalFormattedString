# TerminalFormattedString

<img src="https://img.shields.io/github/license/patrickdeanbrown/TerminalFormattedString?style=for-the-badge">

## Overview
`TerminalFormattedString` provides a lightweight, readable, and portable way to format and store 
formatted strings for output on a tty, such as the MacOS Terminal app. It uses ANSI escape sequences for applying
text color, background color, and text styles.

Specifying text formatting is straigtforward and familiar to those setting color properties in IDEs such as XCode,
and it should read like plain English.

```swift
var formattedText = TerminalFormattedString("Hello, World!",
                                            foregroundColor: .red,
                                            backgroundColor: .blue,
                                            style: [.bold, .italic])
```



ANSI escape sequence data for Select Graphics Rendition (SGR) can be summarized as an integer, which make
`foregroundColor`, `backgroundColor`, and `style`, easily expressed through integer enums. Enums also allow XCode 
and other IDEs to provide a dropdown menu of options for `foregroundColor`, `backgroundColor`, and `style`. `style`
is a `Set` and can contain multiple options, in order allow combined text styles such as bold and underlined text.

(The enum implementation comes from [ColorizeSwift](https://github.com/mtynior/ColorizeSwift), which extends the `String` builtin and is worth checking out.)

## Usage Examples

**Reusable Indicators**

`TerminalFormattedString` is useful for formatted text that is formatted once and reused. It also can be combined with string literals using the + operator.

```swift
var isJavascriptEnabled: Bool = false
var isJSONLibraryInstalled: Bool = true
var isServerConnected: Bool = true

var testPass = TerminalFormattedString("Pass",
                                        foregroundColor: .green,
                                        backgroundColor: .black,
                                        style: [.bold])

var testFail = TerminalFormattedString("Fail",
                                       foregroundColor: .red,
                                       backgroundColor: .black,
                                       style: [.bold])

print("[ " + (isJavascriptEnabled ? testPass : testFail) + " ]" + " JavaScript Enabled")
print("[ " + (isJSONLibraryInstalled ? testPass : testFail) + " ]" + " JSON Library Installed")
print("[ " + (isServerConnected ? testPass : testFail) + " ]" + " Connected to Remote Server")

```
<img src="Assets/pass_fail.png" width="300">


