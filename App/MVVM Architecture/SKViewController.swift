//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit

class SKViewController<V: UIView & SKModelledView>: UIViewController {

  /// The rootView associated with the `SKViewController`.
  var rootView: V {
    return self.view as! V
  }

  /// The latest `SKViewModel` received by this `SKViewController`
  /// This should not be directly set. Please use `update(to: V.VM)`.
  var viewModel: V.VM? {
    didSet {
      // the viewModel is changed: update the View (if loaded)
      if self.isViewLoaded {
        self.rootView.model = viewModel
      }
    }
  }

  /// An more convenient initializer.
  /// Since I am not using the storyboard
  init() {
    super.init(nibName: nil, bundle: nil)
  }

  /// Required init.
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /// Used to load the specific main view managed by this view controller.
  override func loadView() {
    super.loadView()
    let v = V(frame: .zero)
    v.viewController = self
    v.configure()
    v.style()
    self.view = v
  }

  /// Called after the controller's view is loaded into memory.
  override func viewDidLoad() {
    super.viewDidLoad()
    if let vm = self.viewModel {
      self.rootView.model = vm
    }
    self.setupInteraction()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    (self.view as! V).layout()
  }

  /// Called everytime the VM needs to be updated.
  /// Should be called on the main Thread.
  ///
  /// - Parameter newModel: The new `SKViewModel`
  func update(to newModel: V.VM) {
    self.viewModel = newModel
  }

  /// Asks to setup the interaction with the managed view, override point for subclasses.
  open func setupInteraction() {}
}
