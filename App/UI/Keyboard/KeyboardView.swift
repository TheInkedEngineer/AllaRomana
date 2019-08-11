//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit
import SwiftKnife

class KeyboardView: UIView, SKView {

  // MARK: - Properties

  /// The delegate to manage the various events.
  weak var delegate: KeyboardDelegate?

  /// The height of the keyboard.
  static let keyboardHeight = UIScreen.portraitHeight * 0.32383808

  /// The width of the keyboard
  static let keyboardWidth = UIScreen.portraitWidth

  /// A shared instance of the keyboard
  static var shared: KeyboardView {
    #warning("this does not currently work for keywindow is nil")
    let bottomSafeAreaInsets = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0

    let frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.portraitWidth,
      height: UIScreen.portraitHeight * 0.32383808 + bottomSafeAreaInsets
    )

    return KeyboardView(frame: frame)
  }

  /// The keys inside the keypad.
  let keys: [NumpadKey] = [.one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal, .zero, .backspace]

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

  func update() {

  }

  func layout() {
    self.keypadCollection.translatesAutoresizingMaskIntoConstraints = false
    self.keypadCollection.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    self.keypadCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    self.keypadCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    self.keypadCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
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


// Mark: - DataSource

extension KeyboardView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.keys.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeypadCell.identifier, for: indexPath) as? KeypadCell else {
      SKFatalError("Could not properly dequeue cell.")
    }

    cell.model = KeypadCellVM(text: self.keys[safe: indexPath.row]?.visualValue, image: nil)
    return cell
  }
}
