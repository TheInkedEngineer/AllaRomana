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
  let billTotalTextField = CustomTextField(type: .money)

  /// The label for the bill total.
  let tipPercentageLabel = UILabel()

  /// The textField to insert the bill total.
  let tipPercentageTextField = CustomTextField(type: .tips)

  // MARK: - Interactions

  /// Resets the content of the page.
  var didTapResetButton: Interaction?

  /// Opens the settings button.
  var didTapSettingsButton: Interaction?

  /// The amount inside the `bill total` UITextField changed.
  var didUpdateBillTotal: ((Int?) -> Void)?

  /// The amount inside the `percentage` UITextField changed.
  var didUpdateTipPercentage: ((Int?) -> Void)?

  // MARK: - CSLU
  
  func configure() {
    self.addSubview(self.resetButton)
    self.addSubview(self.settingsButton)
    self.addSubview(self.billTotalLabel)
    self.addSubview(self.billTotalTextField)
    self.addSubview(self.tipPercentageLabel)
    self.addSubview(self.tipPercentageTextField)

    self.billTotalTextField.delegate = self
    self.billTotalTextField.inputView = KeyboardView.shared
    (self.billTotalTextField.inputView as? KeyboardView)?.delegate = self.billTotalTextField
    self.billTotalTextField.addTarget(self, action: #selector(self.updatedBillTotal), for: .editingChanged)

    self.tipPercentageTextField.delegate = self
    self.tipPercentageTextField.inputView = KeyboardView.shared
    (self.tipPercentageTextField.inputView as? KeyboardView)?.delegate = self.tipPercentageTextField
    self.tipPercentageTextField.addTarget(self, action: #selector(self.updatedTipPercentage), for: .editingChanged)

    self.resetButton.addTarget(self, action: #selector(tappedResetButton), for: .touchUpInside)
    self.settingsButton.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
  }

  func style() {
    MainView.styleMainView(self)
    MainView.styleSettingsIcon(self.settingsButton)
    MainView.styleResetIcon(self.resetButton)
    MainView.styleBillTotalLabel(self.billTotalLabel)
    MainView.styleBillTotalTextField(self.billTotalTextField, currency: Currency.euro.rawValue)
    MainView.styleTipPercentageLabel(self.tipPercentageLabel)
    MainView.styleTipPercentageTextField(self.tipPercentageTextField)
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

    self.tipPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
    self.tipPercentageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MainView.leftMargin).isActive = true
    self.tipPercentageLabel.topAnchor.constraint(equalTo: self.billTotalTextField.bottomAnchor, constant: 30).isActive = true
    self.tipPercentageLabel.sizeToFit()

    self.tipPercentageTextField.translatesAutoresizingMaskIntoConstraints = false
    self.tipPercentageTextField.leadingAnchor.constraint(equalTo: self.tipPercentageLabel.leadingAnchor).isActive = true
    self.tipPercentageTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: MainView.rightMargin).isActive = true
    self.tipPercentageTextField.topAnchor.constraint(equalTo: self.tipPercentageLabel.bottomAnchor, constant: 10).isActive = true
    self.tipPercentageTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
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

  @objc private func updatedTipPercentage() {
    guard let text = self.tipPercentageTextField.text else { return }
    self.didUpdateTipPercentage?(Int(text))
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

  private static func styleTipPercentageLabel(_ label: UILabel) {
    label.attributedText = NSAttributedString(string: "Tip Percentage", attributes: TextStyle.sectionTitle)
    label.numberOfLines = 0
    label.minimumScaleFactor = 0.6
  }

  private static func styleTipPercentageTextField(_ textField: UITextField) {
    textField.attributedPlaceholder = NSAttributedString(string: "0 %", attributes: TextStyle.textFieldPlaceholder)
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
