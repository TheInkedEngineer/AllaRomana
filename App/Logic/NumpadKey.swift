//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import Foundation

#warning("Decimal key needs to be localized.")

/// An enum containing all the available keys on the numpad.
enum NumpadKey {
  case zero
  case one
  case two
  case three
  case four
  case five
  case six
  case seven
  case eight
  case nine
  case decimal
  case backspace

  /// The replacement value in a text field of each case.
  /// It is used instead of raw value for future implementation of localization.
  /// Raw value cannot be localized.
  var replacementValue: String {
    switch self {
    case .zero:
      return "0"
    case .one:
      return "1"
    case .two:
      return "2"
    case .three:
      return "3"
    case .four:
      return "4"
    case .five:
      return "5"
    case .six:
      return "6"
    case .seven:
      return "7"
    case .eight:
      return "8"
    case .nine:
      return "9"
    case .decimal:
      return "."
    case .backspace:
      return ""
    }
  }

  /// The visual value of each case. That is how it is displayed to the use inside the keyboard.
  var visualValue: String {
    switch self {
    case .zero:
      return "0"
    case .one:
      return "1"
    case .two:
      return "2"
    case .three:
      return "3"
    case .four:
      return "4"
    case .five:
      return "5"
    case .six:
      return "6"
    case .seven:
      return "7"
    case .eight:
      return "8"
    case .nine:
      return "9"
    case .decimal:
      return "."
    case .backspace:
      return "clear"
    }
  }


  /// Lookup and returns the `NumpadKey` value equivalent to a string.
  ///
  /// - Parameter string: The value to lookup.
  /// - Returns: `NumpadKey` value if found, otherwise nil.
  static func key(for string: String) -> NumpadKey? {
    switch string {
    case "0":
      return .zero
    case "1":
      return .one
    case "2":
      return .two
    case "3":
      return .three
    case "4":
      return .four
    case "5":
      return .five
    case "6":
      return .six
    case "7":
      return .seven
    case "8":
      return .eight
    case "9":
      return .nine
    case ".":
      return .decimal
    case "":
      return .backspace
    default:
      return nil
    }
  }
}
