//
//  AllaRomana
//
//  Copyright © 2019 TheInkedEngineer. All rights reserved.
// 

import UIKit
import SwiftKnife

class KeypadCellVM: SKViewModel {

  // MARK: - Variables

  /// the possible text to write in the cell.
  var text: String?

  /// the possible image inside the cell.
  var image: UIImage?

  /// Whether or not to display the text.
  var shouldShowText: Bool {
    guard let text = self.text, text.isNotEmpty else {
      return false
    }
    return true
  }

  /// Whether or not to display the image.
  var shouldShowImage: Bool {
    return self.image != nil
  }

  init(text: String?, image: UIImage?) {
    self.text = text
    self.image = image
  }
}

class KeypadCell: UICollectionViewCell, SKModelledView {

  // MARK: - Properties

  /// The unique identifier of the cell.
  static let identifier = "KeypadCell"

  override var reuseIdentifier: String? {
    return KeypadCell.identifier
  }

  /// The label containing the optional text.
  let label = UILabel()

  /// The possible image of the button.
  let imageView = UIImageView()

  // MARKK: - init

  /// init by code.
  override init(frame: CGRect) {
    super.init(frame: frame)

    self.configure()
    self.style()
    self.layout()
  }

  /// init through IB.
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    self.configure()
    self.style()
    self.layout()
  }

  // MARK: CSUL

  func configure() {
    self.addSubview(self.label)
    self.addSubview(self.imageView)
  }

  func style() {}

  func update(oldModel: KeypadCellVM?) {
    guard let model = self.model else { SKFatalError("Expecting a viewmodel.") }

    KeypadCell.styleNumber(self.label, with: model.text, isVisible: model.shouldShowText)
    KeypadCell.styleImage(self.imageView, with: model.image, isVisible: model.shouldShowImage)
  }

  func layout() {

    self.label.translatesAutoresizingMaskIntoConstraints = false
    self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.label.sizeToFit()

    self.imageView.translatesAutoresizingMaskIntoConstraints = false
    self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    self.imageView.sizeToFit()
  }
}

// MARK: - Styling functions

extension KeypadCell {
  private static func styleCell(_ cell: UICollectionViewCell) {
    cell.backgroundColor = .p3Random
  }

  private static func styleNumber(_ label: UILabel, with content: String?, isVisible: Bool) {
    guard let content = content, isVisible else {
      label.isHidden = true
      return
    }
    label.attributedText = NSAttributedString(string: content, attributes: TextStyle.KeypadContent)
    label.isVisible = true
  }

  private static func styleImage(_ view: UIImageView, with image: UIImage?, isVisible: Bool) {
    guard let image = image, isVisible else {
      view.isHidden = true
      return
    }
    view.image = image
    view.isVisible = true
  }
}
