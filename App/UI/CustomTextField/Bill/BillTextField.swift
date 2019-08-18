//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

class BillTextField: UITextField {

  var textFieldType: UITextFieldType

  override init(frame: CGRect) {
    self.textFieldType = .money
    super.init(frame: .zero)
  }

  required init?(coder aDecoder: NSCoder) {
    self.textFieldType = .money
    super.init(coder: aDecoder)
  }
}
