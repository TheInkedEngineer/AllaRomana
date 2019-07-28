//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

enum TextStyle {
  static var textFieldPlaceholder: [NSAttributedString.Key: Any] {
    return [
      .foregroundColor: Palette.lightGrey.withAlphaComponent(0.1),
      .font: UIFont.systemFont(ofSize: 24, weight: .bold)
    ]
  }

  static var KeypadContent: [NSAttributedString.Key: Any] {
    return [
      .foregroundColor: Palette.white,
      .font: UIFont.systemFont(ofSize: 24, weight: .medium)
    ]
  }
}
