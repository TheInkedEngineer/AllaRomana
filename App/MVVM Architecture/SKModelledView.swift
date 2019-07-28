//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

fileprivate var viewControllerKey = "modelledView_VC_key"
fileprivate var modelKey = "modelledView_model_key"

/// A View powered by a view model.
protocol SKModelledView: SKView {

  /// The type of the view model associated with the view.
  associatedtype VM: SKViewModel

  /// The ViewModel of the View. Once changed, the `update(oldModel: VM?)` will be called.
  /// This is initially created by the VC when the view loads
  /// Swift is inferring the Type through the `oldModel` parameter of the `update(oldModel: ViewModel?)` method
  var model: VM? { get set }

  /// Called when the view modekl changes.
  /// Should not be called directly.
  /// Update the view using `self.model`.
  func update(oldModel: VM?)
}

/// I want to provide a default implementation for the `SKModelledView` protocol.
/// In order to do so, I leverage protocol extentions
/// In order to overcome the inability of using stored values in an extention,
/// I use the associatedObject mechanism.
extension SKModelledView {

  /// Syntactic sugar to access the `SKViewController` that is managing this View.
  /// We use the Associated Object to get around the limitation of computed variables in a protocol extention
  var viewController: UIViewController? {
    get {
      return objc_getAssociatedObject(self, &viewControllerKey) as? UIViewController
    }

    set {
      objc_setAssociatedObject(
        self,
        &viewControllerKey,
        newValue,
        .OBJC_ASSOCIATION_ASSIGN
      )
    }
  }

  /// The ViewModel of the View. Once changed, the `update(oldModel: VM?)` will be called.
  /// The model variable is automatically created when conforming to the ViewWithModel protocol.
  /// Swift is inferring the Type through the `oldModel` parameter of the `update(oldModel: ViewModel?)` method
  var model: VM? {
    get {
      return objc_getAssociatedObject(self, &modelKey) as? VM
    }

    set {
      let oldModel = self.model
      objc_setAssociatedObject(
        self,
        &modelKey,
        newValue,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
      self.update(oldModel: oldModel)
    }
  }

  /// Will throw a fatalError. Use `update(oldMdel:)` instead.
  func update() {
    fatalError("You should not use \(#function) in a ModellableView. Change the model instead" )
  }
}


