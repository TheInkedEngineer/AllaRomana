//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import Foundation

protocol SKView: AnyObject {
  /// The configuration phase should execute only once when the `SKView` is created.
  /// Typically during this phase, subviews are added and possible tap gestures are configured.
  func configure()

  /// The style phase should execute only once when the `SKView` is created,
  /// right after the setup phase.
  /// Styling properties that do not change over time are called at this point.
  /// For all the style attributes that change depending on the "state" of the view,
  /// look at the `View.update()` phase.
  func style()

  /// The update phase should execute every time the "state" of the view changes.
  /// This phase should reflect such changes.
  func update()

  /// The layout phase is where you define the layout of your view.
  func layout()
}
