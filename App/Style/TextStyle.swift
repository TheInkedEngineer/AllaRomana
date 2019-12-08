//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

enum TextStyle {

  static var sectionTitleLightBackground: [NSAttributedString.Key: Any] {
    [
      .foregroundColor: Palette.lightGrey,
      .font: UIFont.systemFont(ofSize: 14, weight: .medium)
    ]
  }

  static var sectionTitleDarkBackground: [NSAttributedString.Key: Any] {
    [
      .foregroundColor: Palette.white,
      .font: UIFont.systemFont(ofSize: 14, weight: .medium)
    ]
  }

  static var textFieldPlaceholder: [NSAttributedString.Key: Any] {
    [
      .foregroundColor: Palette.lightGrey.withAlphaComponent(0.1),
      .font: UIFont.systemFont(ofSize: 24, weight: .bold)
    ]
  }

  static var populatedFieldTextLightBackground: [NSAttributedString.Key: Any] {
    [
      .foregroundColor: Palette.black,
      .font: UIFont.systemFont(ofSize: 24, weight: .bold)
    ]
  }

  static var populatedFieldTextDarkBackground: [NSAttributedString.Key: Any] {
    [
      .foregroundColor: Palette.yellow,
      .font: UIFont.systemFont(ofSize: 24, weight: .bold)
    ]
  }

  static var keypadContent: [NSAttributedString.Key: Any] {
    [
      .foregroundColor: Palette.white,
      .font: UIFont.systemFont(ofSize: 24, weight: .medium)
    ]
  }
}
