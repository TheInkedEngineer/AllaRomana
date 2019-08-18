//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

extension CustomTextField: KeyboardDelegate {

  /// Properly formatted currency with spacing.
  private var currency: String {
    return " \(SettingsLogic.currency.rawValue)"
  }

  func keyPressed(_ key: NumpadKey) {

    // case decimal key.
    if key == .decimal {
      // if decimal already exists, do nothing.
      guard let text = self.text, text.isNotEmpty, !text.contains(NumpadKey.decimal.visualValue) else { return }
    }

    guard var selectedTextRange = self.selectedTextRange else { return }

    self.removeSuffix()

    // case delete single character
    if key == .backspace, selectedTextRange.start == selectedTextRange.end {
      guard
        let startPosition = self.position(from: selectedTextRange.end, offset: -1),
        let endPosition = self.position(from: selectedTextRange.end, offset: 0),
        let deleteRange = self.textRange(from: startPosition, to: endPosition)

        else {
          return
      }

      selectedTextRange = deleteRange
    }

    self.replace(selectedTextRange, withText: key.replacementValue)
    self.addSuffix()

    // position cursor properly at the end of the last digit
    self.placeCursorAtLastDigit()

    // this is done here to get a fresh copy of the text content after various updates.
    guard let updatedText = self.text else { return }

    // clear text when no numbers are left.
    if !updatedText.containsDigit {
      self.text = ""
    }
  }
}

// MARK: - Helpers

extension CustomTextField {

  /// Removes the suffix at the end of the string in order to have only the digits to manipulate.
  private func removeSuffix() {
    switch self.textFieldType {
    case .money:
      self.removeCurrency()
    case .tips:
      self.removePercentage()
    }
  }

  /// Adds the suffix at the end of the string in order to have it properly formatted.
  private func addSuffix() {
    switch self.textFieldType {
    case .money:
      self.addCurrency()
    case .tips:
      self.addPercentage()
    }
  }

  /// Removes the currency from end of string.
  private func removeCurrency() {
    if let text = self.text, text.count > 0 {
      guard let rangeOfCurrency = text.range(of: self.currency) else { return }
      self.text?.removeSubrange(rangeOfCurrency)
    }
  }

  /// Adds the currency to end of string.
  private func addCurrency() {
    self.text?.append(self.currency)
  }

  /// Adds the percentage symbol to end of string.
  private func addPercentage() {
    self.text?.append(" %")
  }

  /// Removes the percentage symbol from end of string.
  private func removePercentage() {
    if let text = self.text, text.count > 0 {
      guard let rangeOfPercentage = text.range(of: " %") else { return }
      self.text?.removeSubrange(rangeOfPercentage)
    }
  }

  /// Position the curson at the end of the digits string before the currency or percentage suffix.
  private func placeCursorAtLastDigit() {
    guard let text = self.text else { return }
    let offset: Int
    switch self.textFieldType {
    case .money:
      offset = text.count - self.currency.count
    case .tips:
      offset = text.count - 2
    }
    guard let position = self.position(from: beginningOfDocument, offset: offset) else { return }
    self.selectedTextRange = self.textRange(from: position, to: position)
  }
}

