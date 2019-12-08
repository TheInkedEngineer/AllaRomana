//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

    self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
    let vc = MainVC()
    let vm = MainVM(
      currentBillAmount: nil,
      currentTipPercentage: nil,
      numberOfShares: 1,
      sharePerPerson: 0
    )
    vc.viewModel = vm
    self.window?.rootViewController = vc
    self.window?.makeKeyAndVisible()

    return true
  }

}

