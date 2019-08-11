//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

extension UITextField: KeyboardDelegate {
  func keyPressed(_ key: NumpadKey) {

    guard var selectedTextRange = self.selectedTextRange else {
      return
    }

    // case delete single character
    if key == .backspace, selectedTextRange.start == selectedTextRange.end {
      guard
        let startPosition = self.position(from: selectedTextRange.end, offset: -1),
        let endPosition = self.position(from: selectedTextRange.end, offset: 0),
        let deleteRange = self.textRange(from: startPosition, to: endPosition) else {
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
  }
}
