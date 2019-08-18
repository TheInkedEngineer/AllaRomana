//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

extension BillTextField: KeyboardDelegate {
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

    self.removeCurrency()

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
    self.addCurrency()

    // position cursor properly at the end of the last digit
    self.adjustCursorPosition()

    // this is done here to get a fresh copy of the text content after various updates.
    guard let updatedText = self.text else { return }

    // clear text when no numbers are left.
    if !updatedText.containsDigit {
      self.text = ""
    }
  }
}

// MARK: - Helpers

extension BillTextField {
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

  /// Position the curson at the desired position (offset) compared to the start of the document.
  ///
  /// - Parameter offset: The desired offset.
  private func adjustCursorPosition() {
    guard let text = self.text else { return }
    let offset = text.count - self.currency.count
    guard let position = self.position(from: beginningOfDocument, offset: offset) else { return }
    self.selectedTextRange = self.textRange(from: position, to: position)
  }
}

extension String {
  /// Checks if the String contains any digit.
  var containsDigit: Bool {
    guard !self.isEmpty else { return false }
    return self.contains { Int(String($0)) != nil }
  }
}
