//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

class CustomTextField: UITextField {

  /// The type of the `CustomTextField` out of the `UITextFieldType` types.
  var textFieldType: UITextFieldType

  // MARK: - INIT

  /// Initializes the `CustomTextField` with the desired type. Otherwise it is inizialized as `money` type by default.
  ///
  /// - Parameter type: The desired `UITextFieldType` with which to initialize the `CustomTextField`.
  convenience init(type: UITextFieldType) {
    self.init(frame: .zero)
    self.textFieldType = type
  }

  /// Initializes the `CustomTextField` with the desired Frame. By default the `textFieldType` is of value `.money`.
  override init(frame: CGRect) {
    self.textFieldType = .money
    super.init(frame: .zero)
  }

  /// Initializes the `CustomTextField` with the desired Frame. By default the `textFieldType` is of value `.money`.
  required init?(coder aDecoder: NSCoder) {
    self.textFieldType = .money
    super.init(coder: aDecoder)
  }
}
