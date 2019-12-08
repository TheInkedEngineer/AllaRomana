//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import BloodyMary
import SwiftKnife
import UIKit

class KeyboardView: UIView, BMView {
  
  // MARK: - Properties
  
  /// The delegate to manage the various events.
  weak var delegate: KeyboardDelegate?
  /// The height of the keyboard.
  static let keyboardHeight = UIScreen.portraitHeight * 0.32383808
  /// The width of the keyboard
  static let keyboardWidth = UIScreen.portraitWidth
  /// The keys inside the keypad.
  let keys: [NumpadKey] = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal, .zero, .backspace]
  
  /// A shared instance of the keyboard
  static var `default`: KeyboardView {
    // if the keyboard is to be used in the main view before the keyWindow is set (like in this app's case)
    // there is no way to find out the actual bottom safe area.
    // In order to fit newer iPhones without compromising that space we add a fallback value of 40.
    var bottomSafeAreaInsets: CGFloat {
      if let keyWindow = UIApplication.shared.keyWindow {
        return keyWindow.safeAreaInsets.bottom
      }
      
      let device = UIDevice().device
      
      if
        device == .iPhoneSE ||
        device == .iPhone6 ||
        device == .iPhone7 ||
        device == .iPhone8 ||
        UIScreen.portraitHeight <= 667 {
        return 0
      }
      return 34
    }
    
    let frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.portraitWidth,
      height: UIScreen.portraitHeight * 0.32383808 + bottomSafeAreaInsets
    )
    
    return KeyboardView(frame: frame)
  }
  
  // MARK: - UI Elements
  
  lazy var keypadCollection: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    layout.itemSize = CGSize(width: UIScreen.portraitWidth / 3, height: KeyboardView.keyboardHeight / 4)
    let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collection.register(KeypadCell.self, forCellWithReuseIdentifier: KeypadCell.identifier)
    collection.bounces = false
    collection.isScrollEnabled = false
    return collection
  }()
  
  // MARK: - init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.configure()
    self.style()
    self.layout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    self.configure()
    self.style()
    self.layout()
  }
  
  
  // MARK: - CSUL
  
  func configure() {
    self.keypadCollection.delegate = self
    self.keypadCollection.dataSource = self
    self.addSubview(self.keypadCollection)
  }
  
  func style() {
    KeyboardView.styleKeyboard(self)
  }
  
  func update() {}
  
  func layout() {
    self.keypadCollection.activateAutoLayout()
    self.keypadCollection.topAnchor.constraint(equalTo: self.topAnchor).activate()
    self.keypadCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).activate()
    self.keypadCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).activate()
    self.keypadCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).activate()
  }
}

// MARK: - Styling Functions

extension KeyboardView {
  private static func styleKeyboard(_ view: UIView) {
    view.backgroundColor = Palette.black
    view.layer.masksToBounds = false
    view.layer.shadowColor = Palette.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: -2.0)
    view.layer.shadowRadius = 2.5
    view.layer.shadowOpacity = 0.5
  }
}

// MARK: - Delegate

extension KeyboardView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let numpadKey = self.keys[safe: indexPath.row] else { return }
    self.delegate?.keyPressed(numpadKey)
  }
}


// MARK: - DataSource

extension KeyboardView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.keys.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeypadCell.identifier, for: indexPath) as? KeypadCell else {
        SKFatalError("Could not properly dequeue cell.")
    }
    
    cell.viewModel = KeypadCellVM(text: self.keys[safe: indexPath.row]?.visualValue, image: nil)
    return cell
  }
}
