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
  let currentBillAmount: Int?
}
