//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

protocol KeyboardDelegate: AnyObject {
  /// A key on the keyboard was pressed.
  func keyPressed(_ key: NumpadKey)
}
