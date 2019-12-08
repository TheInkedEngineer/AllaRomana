//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import Foundation

class MainVC: BMViewController<MainView> {

  override func setupInteractions() {
    super.setupInteractions()

    self.rootView.didTapResetButton = { [weak self] in
      self?.viewModel = MainVM(
        currentBillAmount: nil,
        currentTipPercentage: nil,
        numberOfShares: 1,
        sharePerPerson: 0
      )
      self?.rootView.billTotalTextField.becomeFirstResponder()
    }

    self.rootView.didTapDecreaseSharesButton = { [weak self] in
      guard let model = self?.viewModel else { return }

      let sharePerPerson = MainViewLogic.calculateShare(
        bill: model.currentBillAmount ?? 0,
        tip: model.currentTipPercentage ?? 0,
        persons: model.numberOfShares - 1
      )

      self?.viewModel = MainVM(
        currentBillAmount: model.currentBillAmount,
        currentTipPercentage: model.currentTipPercentage,
        numberOfShares: model.numberOfShares - 1,
        sharePerPerson: sharePerPerson
      )
    }

    self.rootView.didTapIncreaseSharesButton = { [weak self] in
      guard let model = self?.viewModel else { return }

      let sharePerPerson = MainViewLogic.calculateShare(
        bill: model.currentBillAmount ?? 0,
        tip: model.currentTipPercentage ?? 0,
        persons: model.numberOfShares + 1
      )

      self?.viewModel = MainVM(
        currentBillAmount: model.currentBillAmount,
        currentTipPercentage: model.currentTipPercentage,
        numberOfShares: model.numberOfShares + 1,
        sharePerPerson: sharePerPerson
      )
    }

    self.rootView.didUpdateBillTotal = { [weak self] amount in
      guard let model = self?.viewModel else { return }

      let sharePerPerson = MainViewLogic.calculateShare(
        bill: amount ?? 0,
        tip: model.currentTipPercentage ?? 0,
        persons: model.numberOfShares
      )

      self?.viewModel = MainVM(
        currentBillAmount: amount,
        currentTipPercentage: model.currentTipPercentage,
        numberOfShares: model.numberOfShares,
        sharePerPerson: sharePerPerson
      )
    }

    self.rootView.didUpdateTipPercentage = { [weak self] amount in
      guard let model = self?.viewModel else { return }

      let sharePerPerson = MainViewLogic.calculateShare(
        bill: model.currentBillAmount ?? 0,
        tip: amount ?? 0,
        persons: model.numberOfShares
      )

      self?.viewModel = MainVM(
        currentBillAmount: model.currentBillAmount,
        currentTipPercentage: amount,
        numberOfShares: model.numberOfShares,
        sharePerPerson: sharePerPerson
      )
    }
  }
}
