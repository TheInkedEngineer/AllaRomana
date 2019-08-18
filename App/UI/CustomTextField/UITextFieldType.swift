//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import Foundation

/// The type of the `UITextField`.
///
/// - money: Money related, where the textfield always end with the currency.
/// - tips: Percentage related, where the textfield always ends with &, and cannot go over 100.
enum UITextFieldType {
  case money
  case tips
}
