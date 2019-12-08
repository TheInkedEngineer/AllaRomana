//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import Foundation
import XCTest

@testable import AllaRomana

class MainViewLogicTests: XCTestCase {

  func testCalculateAmountPerPersonSuccessful() {
    let amount = MainViewLogic.calculateShare(bill: 10, tip: 10, persons: 1)
    XCTAssertEqual(amount, 11)
  }
}
