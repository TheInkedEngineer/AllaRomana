//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import Foundation

struct MainVM: SKViewModel {

  #warning("this should be fetched from the user defaults")
  /// The current used currency.
  let currency: String = Currency.euro.rawValue
}
