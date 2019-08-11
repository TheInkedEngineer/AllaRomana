//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

extension UITextField: KeyboardDelegate {
  func keyPressed(_ key: NumpadKey) {

    // remove the current currency logo
    if let text = self.text, text.count > 0 {
      self.text?.removeLast()
    }

    guard var selectedTextRange = self.selectedTextRange else {
      return
    }

    // case delete single character
    if key == .backspace, selectedTextRange.start == selectedTextRange.end {
      guard
        let startPosition = self.position(from: selectedTextRange.end, offset: -1),
        let endPosition = self.position(from: selectedTextRange.end, offset: 0),
        let deleteRange = self.textRange(from: startPosition, to: endPosition)

        else {
        return
      }

      selectedTextRange = deleteRange
    }

    // case decimal key.
    if key == .decimal {
      // if decimal already exists, do nothing.
      guard let text = self.text, !text.contains(NumpadKey.decimal.visualValue) else { return }
    }

    self.replace(selectedTextRange, withText: key.replacementValue)

    // add currency logo
    #warning("this should fetch actual currency.")
    self.text?.append("€")

    guard let text = self.text else { return }

    self.setCursor(at: text.count - 1)

    if text.count < 2 {
      self.text = ""
    }
  }
}

extension UITextField {
  /// Position the curson at the desired position (offset) compared to the start of the document.
  ///
  /// - Parameter offset: The desired offset.
  func setCursor(at offset: Int) {
    guard let position = self.position(from: beginningOfDocument, offset: offset) else { return }
    self.selectedTextRange = self.textRange(from: position, to: position)
  }
}
