//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

extension UITextField: KeyboardDelegate {
  func keyPressed(_ key: NumpadKey) {

    guard
      let selectedTextRange = self.selectedTextRange,
      let selectedNSRange = self.selectedNSRange else {
        return
    }

    // case delete single character
    if key == .backspace, selectedTextRange.start == selectedTextRange.end {
      guard selectedNSRange.location > 0 else { return }
      self.text?.removeLast()
      return
    }

    // case decimal key.
    if key == .decimal {
      // if decimal already exists, do nothing.
      guard let text = self.text, !text.contains(NumpadKey.decimal.visualValue) else { return }
    }

    self.replace(selectedTextRange, withText: key.replacementValue)
  }
}

extension UITextField {
  var selectedNSRange: NSRange? {
    guard let range = selectedTextRange else { return nil }
    let location = offset(from: beginningOfDocument, to: range.start)
    let length = offset(from: range.start, to: range.end)
    return NSRange(location: location, length: length)
  }
}
