//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import Foundation

enum SettingsLogic {
  static var currency: Currency {
    get {
      return UserDefaults.standard.object(forKey: UserDefaultsKey.currency.rawValue) as? Currency ?? .euro
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKey.currency.rawValue)
    }
  }
}
