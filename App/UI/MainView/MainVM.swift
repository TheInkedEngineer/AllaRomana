//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation
import SKWorldCurrencies

struct MainVM: BMViewModel {
  /// The current used currency.
  let currencySymbol: String = Currency.euro.symbol
  /// the currently inserted bill amount.
  let currentBillAmount: Double?
  /// the currently inserted bill amount.
  let currentTipPercentage: Double?
  /// the number of people splitting the bill.
  let numberOfShares: Int
  /// the total amout to pay per person.
  let sharePerPerson: Double
  /// Whether or not to delete the content of the textfield.
  /// Returns true when the `currentBillAmount` is `nil`.
  var shouldDeleteBillTotalTextFieldContent: Bool { self.currentBillAmount == nil }
  /// Whether or not to delete the content of the textfield.
  /// Returns true when the `currentTipPercentage` is `nil`.
  var shouldDeleteTipPercentageTextFieldContent: Bool { self.currentTipPercentage == nil }
  /// The text to display as the title for the share per person section.
  var sharePerPersonTitleText: String {
    self.numberOfShares == 1 ? "You should pay" : "Each person should pay"
  }
  /// Whether or not the `decreaseNumberOfSharesButton` is enabled.
  var isDecreaseNumberOfSharesButtonEnabled: Bool { self.numberOfShares > 1 }
  /// Whether or not the `increaseaNumberOfSharesButton` is enabled.
  var increaseNumberOfSharesButtonEnabled: Bool {
    guard let currentBillAmount = self.currentBillAmount, currentBillAmount > 0 else {
      return false
    }
    return true
  }
}
