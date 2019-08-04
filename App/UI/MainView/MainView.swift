//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit
import SwiftKnife

class MainView: UIView, SKModelledView {

  // MARK: - UI Elements

  let billTotalTextField = UITextField()

  // MARK: - CSLU
  
  func configure() {
    self.addSubview(self.billTotalTextField)
    self.billTotalTextField.inputView = KeyboardView.shared
    (self.billTotalTextField.inputView as? KeyboardView)?.delegate = billTotalTextField
  }

  func style() {
    MainView.styleMainView(self)
  }

  func layout() {
    self.billTotalTextField.translatesAutoresizingMaskIntoConstraints = false
    self.billTotalTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.billTotalTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.billTotalTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    self.billTotalTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
  }

  func update(oldModel: MainVM?) {
    guard let model = self.model else { SKFatalError("Expecting a viewmodel.") }

    MainView.styleBillTotalTextField(self.billTotalTextField, currency: model.currency)
  }

}

// MARK: - Styling Functions
extension MainView {
  private static func styleMainView(_ view: UIView) {
    view.backgroundColor = Palette.white
  }

  private static func styleBillTotalTextField(_ textField: UITextField, currency: String) {
    textField.attributedPlaceholder = NSAttributedString(string: "0 \(currency)", attributes: TextStyle.textFieldPlaceholder)
  }
}
