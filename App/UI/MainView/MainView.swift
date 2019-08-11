//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit
import SwiftKnife

class MainView: UIView, SKModelledView {

  // MARK: - View Relative Info

  /// The desired right margin of the overall view.
  static let rightMargin: CGFloat = -20

  /// The desired left margin of the overall view.
  static let leftMargin: CGFloat = 20

  // MARK: - UI Elements

  /// The reset content icon.
  let resetButton = SKImageButton()

  /// The settings icon.
  let settingsButton = SKImageButton()

  /// The label for the bill total.
  let billTotalLabel = UILabel()

  /// The textField to insert the bill total.
  let billTotalTextField = UITextField()

  // MARK: - Interactions

  /// Resets the content of the page.
  var didTapResetButton: Interaction?

  /// Opens the settings button.
  var didTapSettingsButton: Interaction?

  /// The amount inside the `bill total` UITextField changed.
  var didUpdateBillTotal: ((Int?) -> Void)?

  // MARK: - CSLU
  
  func configure() {
    self.addSubview(self.resetButton)
    self.addSubview(self.settingsButton)
    self.addSubview(self.billTotalLabel)
    self.addSubview(self.billTotalTextField)
    self.billTotalTextField.delegate = self
    self.billTotalTextField.inputView = KeyboardView.shared
    (self.billTotalTextField.inputView as? KeyboardView)?.delegate = billTotalTextField
    
    self.billTotalTextField.addTarget(self, action: #selector(updatedBillTotal), for: .editingChanged)
    self.resetButton.addTarget(self, action: #selector(tappedResetButton), for: .touchUpInside)
    self.settingsButton.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
  }

  func style() {
    MainView.styleMainView(self)
    MainView.styleBillTotalLabel(self.billTotalLabel)
    MainView.styleBillTotalTextField(self.billTotalTextField, currency: Currency.euro.rawValue)
    MainView.styleSettingsIcon(self.settingsButton)
    MainView.styleResetIcon(self.resetButton)
  }

  func layout() {
    self.resetButton.translatesAutoresizingMaskIntoConstraints = false
    self.resetButton.topAnchor.constraint(equalTo: self.topAnchor, constant: self.safeAreaInsets.top + 20).isActive = true
    self.resetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: MainView.rightMargin).isActive = true
    self.resetButton.widthAnchor.constraint(equalToConstant: Asset.trashCan.image.size.width).isActive = true
    self.resetButton.heightAnchor.constraint(equalToConstant: Asset.trashCan.image.size.height).isActive = true

    self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
    self.settingsButton.centerYAnchor.constraint(equalTo: self.resetButton.centerYAnchor).isActive = true
    self.settingsButton.trailingAnchor.constraint(equalTo: self.resetButton.leadingAnchor, constant: -15).isActive = true
    self.settingsButton.widthAnchor.constraint(equalToConstant: Asset.settingsWheel.image.size.width).isActive = true
    self.settingsButton.heightAnchor.constraint(equalToConstant: Asset.settingsWheel.image.size.height).isActive = true

    self.billTotalLabel.translatesAutoresizingMaskIntoConstraints = false
    self.billTotalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MainView.leftMargin).isActive = true
    self.billTotalLabel.topAnchor.constraint(equalTo: self.settingsButton.bottomAnchor, constant: 30).isActive = true
    self.billTotalLabel.sizeToFit()

    self.billTotalTextField.translatesAutoresizingMaskIntoConstraints = false
    self.billTotalTextField.leadingAnchor.constraint(equalTo: self.billTotalLabel.leadingAnchor).isActive = true
    self.billTotalTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: MainView.rightMargin).isActive = true
    self.billTotalTextField.topAnchor.constraint(equalTo: self.billTotalLabel.bottomAnchor, constant: 10).isActive = true
    self.billTotalTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
  }

  func update(oldModel: MainVM?) {
    guard let model = self.model else { SKFatalError("Expecting a viewmodel.") }

    MainView.styleBillTotalTextField(self.billTotalTextField, currency: model.currency)
  }

  //MARK: - User Interaction

  @objc private func tappedResetButton() {
    self.didTapResetButton?()
  }

  @objc private func tappedSettingsButton() {
    self.didTapSettingsButton?()
  }

  @objc private func updatedBillTotal() {
    guard let text = self.billTotalTextField.text else { return }
    self.didUpdateBillTotal?(Int(text))
  }
}

// MARK: - Styling Functions

extension MainView {
  private static func styleMainView(_ view: UIView) {
    view.backgroundColor = Palette.white
  }

  private static func styleSettingsIcon(_ button: SKImageButton) {
    let image = Asset.settingsWheel.image.withRenderingMode(.alwaysTemplate)
    button.image = image
    button.tintColor = Palette.darkGrey
  }

  private static func styleResetIcon(_ button: SKImageButton) {
    let image = Asset.trashCan.image.withRenderingMode(.alwaysTemplate)
    button.image = image
    button.tintColor = Palette.darkGrey
  }

  private static func styleBillTotalLabel(_ label: UILabel) {
    label.attributedText = NSAttributedString(string: "Bill Total", attributes: TextStyle.sectionTitle)
    label.numberOfLines = 0
    label.minimumScaleFactor = 0.6
  }

  private static func styleBillTotalTextField(_ textField: UITextField, currency: String) {
    textField.attributedPlaceholder = NSAttributedString(string: "0 \(currency)", attributes: TextStyle.textFieldPlaceholder)
    textField.defaultTextAttributes = TextStyle.textFieldText
  }
}

// MARK: - TextField Delegate

extension MainView: UITextFieldDelegate {
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    guard
      action != #selector(copy(_:)),
      action != #selector(cut(_:)),
      action != #selector(selectAll(_:)),
      action != #selector(select(_:)),
      action != #selector(paste(_:))
      else {
        return false
    }

    return super.canPerformAction(action, withSender: sender)
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    guard let key = NumpadKey.key(for: string) else {
      return false
    }

    if
      let text = textField.text,
      key.replacementValue == NumpadKey.decimal.replacementValue,
      text.contains(key.replacementValue) {
      return false
    }

    return true
  }
}
