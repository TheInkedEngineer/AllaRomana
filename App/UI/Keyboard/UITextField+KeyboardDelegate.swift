//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

extension UITextField: KeyboardDelegate {
  func keyPressed(_ key: NumpadKey) {

    // case delete is pressed
    if key == .backspace {
      _ = self.text?.popLast()
      return
    }

    // case decimal key
    if key == .decimal {
      // if decimal already exists, do nothing.
      guard let text = self.text, !text.contains(NumpadKey.decimal.rawValue) else {
        return
      }
    }

    self.text?.append(key.rawValue)
  }
}
