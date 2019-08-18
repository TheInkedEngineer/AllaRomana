//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import Foundation

/// A namespace that contains all the logic related to the `MainView`.
enum MainViewLogic {

  /// Calculates the amount to pay per person.
  ///
  /// - Parameters:
  ///   - bill: The total bill to split.
  ///   - tip: The amount of tip to add to the base price.
  ///   - persons: The number of persons splitting the bill.
  /// - Returns: The amount to pay per person.
  static func calculateShare(
    bill: Double,
    tip: Double,
    persons: Int = 1
    ) -> Double {
    
    precondition(persons > 0, "You cannot split the bill between a non positive number of persons.")
    return (bill + (bill * tip / 100)) / Double(persons)
  }
}
