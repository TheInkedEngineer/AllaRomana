//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import Foundation


class MainVC: SKViewController<MainView> {

  override func setupInteraction() {
    super.setupInteraction()

    rootView.didTapResetButton = { [weak self] in
      #warning("implement")
    }

    rootView.didTapSettingsButton = { [weak self] in
      #warning("implement")
    }
  }
}
