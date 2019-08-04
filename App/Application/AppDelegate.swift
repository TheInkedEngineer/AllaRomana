//
//  AppDelegate.swift
//  AllaRomana
//
//  Created by Firas Safa on 27/07/2019.
//  Copyright © 2019 theinkedengineer. All rights reserved.
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
    let vm = MainVM()
    vc.viewModel = vm
    self.window?.rootViewController = vc
    self.window?.makeKeyAndVisible()

    return true
  }

}

