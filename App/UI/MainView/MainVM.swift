//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import Foundation

struct MainVM: SKViewModel {
  /// The current used currency.
  let currency: String = SettingsLogic.currency.rawValue

  /// the currently inserted bill amount.
  let currentBillAmount: Double?

  /// the currently inserted bill amount.
  let currentTipPercentage: Double?

  /// the number of people splitting the bill.
  let numberOfShares: Int

  /// the total amout to pay per person.
  let totalAmountToPayPerPerson: Double

  /// Whether or not the `decreaseNumberOfSharesButton` is enabled.
  var isDecreaseNumberOfSharesButtonEnabled: Bool {
    return self.numberOfShares > 1
  }
}
