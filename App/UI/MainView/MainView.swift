//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import UIKit
import SKWorldCurrencies
import SwiftKnife

class MainView: UIView, BMViewWithViewControllerAndViewModel {

  // MARK: - View Relative Info

  /// The desired right margin of the overall view.
  static let rightMargin: CGFloat = -20

  /// The desired left margin of the overall view.
  static let leftMargin: CGFloat = 20

  /// The distance present between two different sections.
  static var distanceBetweenSections: CGFloat {
    // case iphone SE
    if UIScreen.portraitHeight <= 568 {
      return 15
    }

    // case iPhone 6, 7, 8
    if UIScreen.portraitHeight <= 667 {
      return 25
    }

    return 30
  }

  /// The distance between a section title and its first child.
  static let distanceFromSectionTitle: CGFloat = 10

  // MARK: - UI Elements

  /// The reset content icon.
  let resetButton = SKImageButton()
  /// The settings icon.
  let settingsButton = SKImageButton()
  /// The label for the bill total.
  let billTotalSectionTitleLabel = UILabel()
  /// The textField to insert the bill total.
  let billTotalTextField = CustomTextField(type: .money)
  /// The label for the bill total.
  let tipPercentageSectionTitleLabel = UILabel()
  /// The textField to insert the bill total.
  let tipPercentageTextField = CustomTextField(type: .tips)
  /// The label of the shares section.
  let sharesSectionTitleLabel = UILabel()
  /// The button to decrease the number of payers.
  let decreaseNumberOfSharesButton = SKImageButton()
  /// The label for the number of payers.
  let numberOfSharesLabel = UILabel()
  /// The button to increase the number of payers.
  let increaseNumberOfSharesButton = SKImageButton()
  /// The background of the share per person section.
  let sharePerPersonSectionBackground = UIView()
  /// The label to use for the sare per person section.
  let sharePerPersonTitleLabel = UILabel()
  /// The amount to pay per share.
  let sharePerPersonAmount = UILabel()

  // MARK: - Interactions

  /// Resets the content of the page.
  var didTapResetButton: Interaction?
  /// Opens the settings button.
  var didTapSettingsButton: Interaction?
  /// The amount inside the `bill total` UITextField changed.
  var didUpdateBillTotal: ((Double?) -> Void)?
  /// The amount inside the `percentage` UITextField changed.
  var didUpdateTipPercentage: ((Double?) -> Void)?
  /// Decreases the amount of shares.
  var didTapDecreaseSharesButton: Interaction?
  /// Increases the amount of shares.
  var didTapIncreaseSharesButton: Interaction?

  // MARK: - CSLU
  
  func configure() {
    self.addSubview(self.resetButton)
    #warning("removed for first release.")
//    self.addSubview(self.settingsButton)
    self.addSubview(self.billTotalSectionTitleLabel)
    self.addSubview(self.billTotalTextField)
    self.addSubview(self.tipPercentageSectionTitleLabel)
    self.addSubview(self.tipPercentageTextField)
    self.addSubview(self.sharesSectionTitleLabel)
    self.addSubview(self.decreaseNumberOfSharesButton)
    self.addSubview(self.numberOfSharesLabel)
    self.addSubview(self.increaseNumberOfSharesButton)
    self.addSubview(self.sharePerPersonSectionBackground)
    self.addSubview(self.sharePerPersonTitleLabel)
    self.addSubview(self.sharePerPersonAmount)

    self.billTotalTextField.delegate = self
    self.billTotalTextField.inputView = KeyboardView.shared
    (self.billTotalTextField.inputView as? KeyboardView)?.delegate = self.billTotalTextField
    self.billTotalTextField.addTarget(self, action: #selector(self.updatedBillTotal), for: .editingChanged)
    self.billTotalTextField.becomeFirstResponder()

    self.tipPercentageTextField.delegate = self
    self.tipPercentageTextField.inputView = KeyboardView.shared
    (self.tipPercentageTextField.inputView as? KeyboardView)?.delegate = self.tipPercentageTextField
    self.tipPercentageTextField.addTarget(self, action: #selector(self.updatedTipPercentage), for: .editingChanged)

    self.resetButton.addTarget(self, action: #selector(tappedResetButton), for: .touchUpInside)
    self.settingsButton.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
    self.decreaseNumberOfSharesButton.addTarget(self, action: #selector(tappedDecreaseSharesButton), for: .touchUpInside)
    self.increaseNumberOfSharesButton.addTarget(self, action: #selector(tappedIncreaseSharesButton), for: .touchUpInside)
  }

  func style() {
    MainView.styleMainView(self)
    MainView.styleSettingsIcon(self.settingsButton)
    MainView.styleResetIcon(self.resetButton)
    MainView.styleBillTotalSectionTitleLabel(self.billTotalSectionTitleLabel)
    MainView.styleTipPercentageSectionTitleLabel(self.tipPercentageSectionTitleLabel)
    MainView.styleSharesSectionTitleLabel(self.sharesSectionTitleLabel)
    MainView.styleIncreaseNumberOfSharesButton(self.increaseNumberOfSharesButton)
    MainView.styleSharePerPersonSectionBackground(self.sharePerPersonSectionBackground)
  }

  func layout() {
    guard let keyboard = self.billTotalTextField.inputView else { return }

    self.resetButton.translatesAutoresizingMaskIntoConstraints = false
    self.resetButton.topAnchor.constraint(equalTo: self.topAnchor, constant: self.safeAreaInsets.top + 20).isActive = true
    self.resetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: MainView.rightMargin).isActive = true
    self.resetButton.widthAnchor.constraint(equalToConstant: Asset.trashCan.image.size.width).isActive = true
    self.resetButton.heightAnchor.constraint(equalToConstant: Asset.trashCan.image.size.height).isActive = true

    #warning("removed for first release.")
//    self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
//    self.settingsButton.centerYAnchor.constraint(equalTo: self.resetButton.centerYAnchor).isActive = true
//    self.settingsButton.trailingAnchor.constraint(equalTo: self.resetButton.leadingAnchor, constant: -15).isActive = true
//    self.settingsButton.widthAnchor.constraint(equalToConstant: Asset.settingsWheel.image.size.width).isActive = true
//    self.settingsButton.heightAnchor.constraint(equalToConstant: Asset.settingsWheel.image.size.height).isActive = true

    self.billTotalSectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.billTotalSectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MainView.leftMargin).isActive = true
    self.billTotalSectionTitleLabel.topAnchor.constraint(equalTo: self.resetButton.bottomAnchor, constant: MainView.distanceBetweenSections).isActive = true
    self.billTotalSectionTitleLabel.sizeToFit()

    self.billTotalTextField.translatesAutoresizingMaskIntoConstraints = false
    self.billTotalTextField.leadingAnchor.constraint(equalTo: self.billTotalSectionTitleLabel.leadingAnchor).isActive = true
    self.billTotalTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: MainView.rightMargin).isActive = true
    self.billTotalTextField.topAnchor.constraint(equalTo: self.billTotalSectionTitleLabel.bottomAnchor, constant: MainView.distanceFromSectionTitle).isActive = true
    self.billTotalTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true

    self.tipPercentageSectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.tipPercentageSectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MainView.leftMargin).isActive = true
    self.tipPercentageSectionTitleLabel.topAnchor.constraint(equalTo: self.billTotalTextField.bottomAnchor, constant: MainView.distanceBetweenSections).isActive = true
    self.tipPercentageSectionTitleLabel.sizeToFit()

    self.tipPercentageTextField.translatesAutoresizingMaskIntoConstraints = false
    self.tipPercentageTextField.leadingAnchor.constraint(equalTo: self.tipPercentageSectionTitleLabel.leadingAnchor).isActive = true
    self.tipPercentageTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: MainView.rightMargin).isActive = true
    self.tipPercentageTextField.topAnchor.constraint(
      equalTo: self.tipPercentageSectionTitleLabel.bottomAnchor,
      constant: MainView.distanceFromSectionTitle
      ).isActive = true
    self.tipPercentageTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true

    self.sharesSectionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.sharesSectionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MainView.leftMargin).isActive = true
    self.sharesSectionTitleLabel.topAnchor.constraint(equalTo: self.tipPercentageTextField.bottomAnchor, constant: MainView.distanceBetweenSections).isActive = true
    self.sharesSectionTitleLabel.sizeToFit()

    self.numberOfSharesLabel.translatesAutoresizingMaskIntoConstraints = false
    self.numberOfSharesLabel.topAnchor.constraint(
      equalTo: self.sharesSectionTitleLabel.bottomAnchor,
      constant: MainView.distanceFromSectionTitle
      ).isActive = true
    self.numberOfSharesLabel.leadingAnchor.constraint(
      equalTo: self.leadingAnchor,
      constant: MainView.leftMargin + Asset.minusButtonEnabled.image.size.width + 15 // left margin + image size + distance from image
      ).isActive = true
    self.numberOfSharesLabel.heightAnchor.constraint(equalToConstant: self.numberOfSharesLabel.intrinsicContentSize.height).isActive = true
    // a fixed with was assigned to avoid having the increase button change position.
    // number 8 is the largest number in size with the apps font.
    // 50 for width is enough to fit 888, plus a scale refactor of 0.2 was assigned to the label to adjust the size.
    self.numberOfSharesLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true

    self.decreaseNumberOfSharesButton.translatesAutoresizingMaskIntoConstraints = false
    self.decreaseNumberOfSharesButton.centerYAnchor.constraint(equalTo: self.numberOfSharesLabel.centerYAnchor).isActive = true
    self.decreaseNumberOfSharesButton.widthAnchor.constraint(equalToConstant: Asset.minusButtonEnabled.image.size.width).isActive = true
    self.decreaseNumberOfSharesButton.heightAnchor.constraint(equalToConstant: Asset.minusButtonEnabled.image.size.height).isActive = true
    self.decreaseNumberOfSharesButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MainView.leftMargin).isActive = true

    self.increaseNumberOfSharesButton.translatesAutoresizingMaskIntoConstraints = false
    self.increaseNumberOfSharesButton.centerYAnchor.constraint(equalTo: self.numberOfSharesLabel.centerYAnchor).isActive = true
    self.increaseNumberOfSharesButton.widthAnchor.constraint(equalToConstant: Asset.plusButtonEnabled.image.size.width).isActive = true
    self.increaseNumberOfSharesButton.heightAnchor.constraint(equalToConstant: Asset.plusButtonEnabled.image.size.height).isActive = true
    self.increaseNumberOfSharesButton.leadingAnchor.constraint(equalTo: self.numberOfSharesLabel.trailingAnchor, constant: 15).isActive = true

    let spaceBetweenSharesAndKeyboard = UILayoutGuide()
    self.addLayoutGuide(spaceBetweenSharesAndKeyboard)
    spaceBetweenSharesAndKeyboard.topAnchor.constraint(equalTo: self.increaseNumberOfSharesButton.bottomAnchor).isActive = true
    spaceBetweenSharesAndKeyboard.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -keyboard.frame.height).isActive = true
    spaceBetweenSharesAndKeyboard.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    spaceBetweenSharesAndKeyboard.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

    self.sharePerPersonSectionBackground.translatesAutoresizingMaskIntoConstraints = false
    self.sharePerPersonSectionBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MainView.leftMargin).isActive = true
    self.sharePerPersonSectionBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: MainView.rightMargin).isActive = true
    self.sharePerPersonSectionBackground.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.12315271).isActive = true
    self.sharePerPersonSectionBackground.centerYAnchor.constraint(equalTo: spaceBetweenSharesAndKeyboard.centerYAnchor).isActive = true

    let sharePerPersonInfoContainer = UILayoutGuide()
    self.addLayoutGuide(sharePerPersonInfoContainer)
    sharePerPersonInfoContainer.heightAnchor.constraint(
      // height of both labels plus the vertical distance between them.
      equalToConstant: self.sharePerPersonTitleLabel.intrinsicContentSize.height + self.sharePerPersonAmount.intrinsicContentSize.height + 10
    ).isActive = true
    sharePerPersonInfoContainer.leadingAnchor.constraint(equalTo: self.sharePerPersonSectionBackground.leadingAnchor, constant: 50).isActive = true
    sharePerPersonInfoContainer.trailingAnchor.constraint(equalTo: self.sharePerPersonSectionBackground.trailingAnchor, constant: -50).isActive = true
    sharePerPersonInfoContainer.centerYAnchor.constraint(equalTo: self.sharePerPersonSectionBackground.centerYAnchor).isActive = true

    self.sharePerPersonTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    self.sharePerPersonTitleLabel.leadingAnchor.constraint(equalTo: sharePerPersonInfoContainer.leadingAnchor).isActive = true
    self.sharePerPersonTitleLabel.trailingAnchor.constraint(equalTo: sharePerPersonInfoContainer.trailingAnchor).isActive = true
    self.sharePerPersonTitleLabel.topAnchor.constraint(equalTo: sharePerPersonInfoContainer.topAnchor).isActive = true
    self.sharePerPersonTitleLabel.sizeToFit()

    self.sharePerPersonAmount.translatesAutoresizingMaskIntoConstraints = false
    self.sharePerPersonAmount.leadingAnchor.constraint(equalTo: sharePerPersonInfoContainer.leadingAnchor).isActive = true
    self.sharePerPersonAmount.trailingAnchor.constraint(equalTo: sharePerPersonInfoContainer.trailingAnchor).isActive = true
    self.sharePerPersonAmount.bottomAnchor.constraint(equalTo: sharePerPersonInfoContainer.bottomAnchor).isActive = true
    self.sharePerPersonAmount.sizeToFit()
  }

  func update(oldViewModel: MainVM?) {
    guard let model = self.viewModel else { SKFatalError("Expecting a viewmodel.") }

    MainView.styleNumberOfSharesLabel(self.numberOfSharesLabel, shares: model.numberOfShares)
    MainView.styleDecreaseNumberOfSharesButton(self.decreaseNumberOfSharesButton, isEnabled: model.isDecreaseNumberOfSharesButtonEnabled)
    MainView.styleBillTotalTextField(self.billTotalTextField, currency: Currency.euro.symbol, shouldReset: model.shouldDeleteBillTotalTextFieldContent)
    MainView.styleTipPercentageTextField(self.tipPercentageTextField, shouldReset: model.shouldDeleteTipPercentageTextFieldContent)
    MainView.styleSharePerPersonTitleLabel(self.sharePerPersonTitleLabel, with: model.sharePerPersonTitleText)
    MainView.styleSharePerPersonAmount(self.sharePerPersonAmount, amount: model.sharePerPerson, currency: model.currencySymbol)
  }

  //MARK: - User Interaction

  @objc private func tappedResetButton() {
    self.didTapResetButton?()
  }

  @objc private func tappedSettingsButton() {
    self.didTapSettingsButton?()
  }

  @objc private func tappedDecreaseSharesButton() {
    self.didTapDecreaseSharesButton?()
  }

  @objc private func tappedIncreaseSharesButton() {
    self.didTapIncreaseSharesButton?()
  }

  @objc private func updatedBillTotal() {
    guard let text = self.billTotalTextField.text else { return }
    self.didUpdateBillTotal?(Double(text))
  }

  @objc private func updatedTipPercentage() {
    guard let text = self.tipPercentageTextField.text else { return }
    self.didUpdateTipPercentage?(Double(text))
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

  private static func styleBillTotalSectionTitleLabel(_ label: UILabel) {
    label.attributedText = NSAttributedString(string: "Bill Total", attributes: TextStyle.sectionTitleLightBackground)
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.6
  }

  private static func styleBillTotalTextField(_ textField: UITextField, currency: String, shouldReset: Bool) {
    textField.attributedPlaceholder = NSAttributedString(string: "0 \(currency)", attributes: TextStyle.textFieldPlaceholder)
    textField.defaultTextAttributes = TextStyle.populatedFieldTextLightBackground
    if shouldReset {
      textField.text = nil
    }
  }

  private static func styleTipPercentageSectionTitleLabel(_ label: UILabel) {
    label.attributedText = NSAttributedString(string: "Tip Percentage", attributes: TextStyle.sectionTitleLightBackground)
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.6
  }

  private static func styleTipPercentageTextField(_ textField: UITextField, shouldReset: Bool) {
    textField.attributedPlaceholder = NSAttributedString(string: "0 %", attributes: TextStyle.textFieldPlaceholder)
    textField.defaultTextAttributes = TextStyle.populatedFieldTextLightBackground
    if shouldReset {
      textField.text = nil
    }
  }

  private static func styleSharesSectionTitleLabel(_ label: UILabel) {
    label.attributedText = NSAttributedString(string: "Shares", attributes: TextStyle.sectionTitleLightBackground)
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.6
  }

  private static func styleDecreaseNumberOfSharesButton(_ button: SKImageButton, isEnabled: Bool) {
    let normalImage = Asset.minusButtonEnabled.image
    let disabledImage = Asset.minusButtonDisabled.image
    button.isEnabled = isEnabled
    button.image = isEnabled ? normalImage : disabledImage
  }

  private static func styleNumberOfSharesLabel(_ label: UILabel, shares: Int) {
    label.attributedText = NSAttributedString(string: "\(shares)", attributes: TextStyle.populatedFieldTextLightBackground)
    label.textAlignment = .center
    label.numberOfLines = 1
    label.minimumScaleFactor = 0.2
    label.adjustsFontSizeToFitWidth = true
  }

  private static func styleIncreaseNumberOfSharesButton(_ button: SKImageButton) {
    let normalImage = Asset.plusButtonEnabled.image
    button.image = normalImage
  }

  private static func styleSharePerPersonSectionBackground(_ view: UIView) {
    view.backgroundColor = Palette.black
    view.layer.cornerRadius = 10
  }

  private static func styleSharePerPersonTitleLabel(_ label: UILabel, with content: String) {
    label.attributedText = NSAttributedString(string: content, attributes: TextStyle.sectionTitleDarkBackground)
    label.textAlignment = .center
    label.numberOfLines = 1
    label.minimumScaleFactor = 0.2
    label.adjustsFontSizeToFitWidth = true
  }

  private static func styleSharePerPersonAmount(_ label: UILabel, amount: Double, currency: String) {
    label.attributedText = NSAttributedString(string: "\(amount) \(currency)", attributes: TextStyle.populatedFieldTextDarkBackground)
    label.textAlignment = .center
    label.numberOfLines = 1
    label.minimumScaleFactor = 0.2
    label.adjustsFontSizeToFitWidth = true
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
