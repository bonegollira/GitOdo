//
//  SomeFieldViewComponent.swift
//  GitOdo
//
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit
import Dollar
import Cartography

extension SomeTextFieldComponent: ViewComponentsLayout {
  
  func configure__self () {
    self.backgroundColor = rgba(255, 255, 255)
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__bottomBorder () {
    self.bottomBorder.backgroundColor = rgba(225, 225, 225)
    self.bottomBorder.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__textFields () {
    for textField in self.textFields {
      textField.clearButtonMode = .Always
      textField.font = UIFont(name: "HelveticaNeue", size: 12)
      textField.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
  }
  
  func configure__doneIcon () {
    self.doneIcon.text = "\u{f03a}"
    self.doneIcon.font = UIFont(name: "octicons", size: 18)
    self.doneIcon.textAlignment = .Center
    self.doneIcon.textColor = rgba(200, 200, 200)
    self.doneIcon.backgroundColor = rgba(255, 255, 255, a: 0)
    self.doneIcon.userInteractionEnabled = true
    self.doneIcon.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__cancelIcon () {
    self.cancelIcon.text = "\u{f081}"
    self.cancelIcon.font = UIFont(name: "octicons", size: 18)
    self.cancelIcon.textAlignment = .Center
    self.cancelIcon.textColor = rgba(255, 0, 0)
    self.cancelIcon.backgroundColor = rgba(255, 255, 255, a: 0)
    self.cancelIcon.userInteractionEnabled = true
    self.cancelIcon.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout__textFields () {
    for (i, textField) in enumerate(self.textFields) {
      let top = CGFloat(44 * i)
      layout(self.textFields[i]) { textField in
        textField.left == textField.superview!.left + 20
        textField.right == textField.superview!.right - 20
        textField.top == textField.superview!.top + top
        textField.height == 44
      }
    }
  }
  
  func autolayout__bottomBorder () {
    layout(self.bottomBorder, self.textFields.last!) { bottomBorder, textField in
      bottomBorder.left == bottomBorder.superview!.left
      bottomBorder.right == bottomBorder.superview!.right
      bottomBorder.top == textField.bottom
      bottomBorder.height == 1
    }
  }
  
  func autolayout__doneIcon () {
    layout(self.doneIcon, self.textFields.last!) {doneIcon, textField in
      doneIcon.left == doneIcon.superview!.left + 50
      doneIcon.top == textField.bottom
      doneIcon.width == 44
      doneIcon.height == 44
    }
  }
  
  func autolayout__cancelIcon () {
    layout(self.cancelIcon, self.textFields.last!) {cancelIcon, textField in
      cancelIcon.right == cancelIcon.superview!.right - 50
      cancelIcon.top == textField.bottom
      cancelIcon.width == 44
      cancelIcon.height == 44
    }
  }
  
  func render (parentView: UIView) {
    parentView.addSubview(self)
    self.addSubview(self.bottomBorder)
    for textField in self.textFields {
      self.addSubview(textField)
    }
    self.addSubview(self.doneIcon)
    self.addSubview(self.cancelIcon)
    self.configure__self()
    self.configure__textFields()
    self.configure__bottomBorder()
    self.configure__doneIcon()
    self.configure__cancelIcon()
    self.autolayout__textFields()
    self.autolayout__bottomBorder()
    self.autolayout__doneIcon()
    self.autolayout__cancelIcon()
  }
}

protocol SomeTextFieldViewDelegate: NSObjectProtocol {
  func someTextFieldView (someTextFieldView: SomeTextFieldComponent, didInputedTexts texts: [String: String])
  func someTextFieldViewDidCanceled (someTextFieldView: SomeTextFieldComponent)
}

class SomeTextFieldComponent: UIView, UITextFieldDelegate {
  
  var textFields = [SomeTextField]()
  let bottomBorder = UIView()
  let doneIcon = UILabel()
  let cancelIcon = UILabel()
  
  weak var delegate: SomeTextFieldViewDelegate?
  
  var responder: UITextField? {
    willSet {
      self.responder?.resignFirstResponder()
    }
    didSet {
      responder?.becomeFirstResponder()
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init (configures: [SomeTextFieldConfigure]) {
    self.textFields = configures.map({ SomeTextField(configure: $0) })
    super.init(frame: CGRectZero)
    for textField in self.textFields {
      textField.delegate = self
      textField.addTarget(self, action: "textFieldDidChangeCharactersInRange:", forControlEvents: .EditingChanged)
    }
    self.doneIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "done"))
    self.cancelIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didCanceled"))
  }
  
  override func becomeFirstResponder() -> Bool {
    self.responder = self.textFields[0]
    return true
  }
  
  func becomeFirstResponderRequiredField () -> Bool {
    let emptyTextFileds = self.textFields.filter({ $0.configure.required && $0.text.isEmpty })
    let isEmpty = emptyTextFileds.count > 0
    if isEmpty {
      self.responder = emptyTextFileds.first!
    }
    return isEmpty
  }
  
  func done () -> Bool {
    if self.becomeFirstResponderRequiredField() {
      return false
    }
    else {
      self.didInputedTexts()
      return true
    }
  }
  
  func clear () {
    self.responder = nil
    for textField in self.textFields {
      textField.text = nil
    }
  }
  
  // MARK: UITextFieldDelegate
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    if !textField.isEqual(self.responder) {
      self.responder = textField
    }
    return true
  }
  
  // not delegate
  func textFieldDidChangeCharactersInRange (sender: UITextField) {
    let isInputedAllRquired = $.every(self.textFields, callback: {(textField: SomeTextField) -> Bool in
      return !(textField.configure.required && textField.text.isEmpty)
    })
    self.doneIcon.textColor = isInputedAllRquired ? rgba(0, 200, 0) : rgba(200, 200, 200)
  }
  
  func textFieldShouldReturn (textField: UITextField) -> Bool {
    return self.done()
  }
  
  // MARK: call delegate
  
  func didInputedTexts () {
    var texts = [String: String]()
    for textField in self.textFields {
      texts[textField.configure.id] = textField.text
    }
    self.clear()
    self.delegate?.someTextFieldView(self, didInputedTexts: texts)
  }
  
  func didCanceled () {
    self.clear()
    self.delegate?.someTextFieldViewDidCanceled(self)
  }
}
