//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit
import SKWorldCurrencies

enum SettingsLogic {
  /// The currency used in the app.
  static var currency: Currency {
    get {
      return UserDefaults.standard.object(forKey: UserDefaultsKey.currency.rawValue) as? Currency ?? .euro
    }
    set {
      UserDefaults.standard.setValue(newValue, forKey: UserDefaultsKey.currency.rawValue)
    }
  }

  /// Shows the `SettingsView`.
  ///
  /// - Parameter viewController: The viewcontroller wanting to display the `SettingsView`
  static func show(from viewController: UIViewController, with model: SettingsVM) {
    let vc = SettingsVC()
    vc.viewModel = model
    vc.modalPresentationStyle = .overCurrentContext
    viewController.present(vc, animated: true)
  }
}
