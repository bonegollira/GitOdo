//
//  SomeFieldViewComponent.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/22.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

protocol SomeFieldViewDelegate: NSObjectProtocol {
  func didInputedField (component: SomeTextFieldComponent, texts: [String: String])
}

extension SomeTextFieldComponent: ViewComponentsLayout {
  
  func configure__self () {
    self.backgroundColor = UIColor.whiteColor()
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
    layout(self.bottomBorder) { bottomBorder in
      bottomBorder.left == bottomBorder.superview!.left
      bottomBorder.right == bottomBorder.superview!.right
      bottomBorder.bottom == bottomBorder.superview!.bottom
      bottomBorder.height == 1
    }
  }
  
  func render (parentView: UIView) {
    parentView.addSubview(self)
    self.addSubview(self.bottomBorder)
    for textField in self.textFields {
      self.addSubview(textField)
    }
    self.configure__self()
    self.configure__textFields()
    self.configure__bottomBorder()
    self.autolayout__textFields()
    self.autolayout__bottomBorder()
  }
}

class SomeTextFieldComponent: UIView, UITextFieldDelegate {
  
  var textFields: [SomeTextField]
  var bottomBorder = UIView()
  
  weak var delegate: SomeFieldViewDelegate?
  var responder: UITextField? {
    didSet {
      responder?.becomeFirstResponder()
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    self.textFields = [SomeTextField]()
    super.init(coder: aDecoder)
  }
  
  init (configures: [SomeTextFieldConfigure]) {
    self.textFields = configures.map({ SomeTextField(configure: $0) })
    super.init(frame: CGRectZero)
    for textField in self.textFields {
      textField.delegate = self
    }
  }
  
  override func becomeFirstResponder() -> Bool {
    self.responder = self.textFields[0]
    return true
  }
  
  func becomeFirstResponderRequiredField () -> Bool {
    let emptyTextFileds = self.textFields.filter({ $0.configure.required && $0.text.isEmpty })
    if emptyTextFileds.count > 0 {
      emptyTextFileds.first!.becomeFirstResponder()
    }
    return emptyTextFileds.count > 0
  }
  
  func clear () {
    self.responder = nil
    for textField in self.textFields {
      textField.text = nil
    }
  }
  
  func kickDidInputedField () {
    var texts = [String: String]()
    for textField in self.textFields {
      texts[textField.configure.id] = textField.text
    }
    self.delegate?.didInputedField(self, texts: texts)
  }
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    if !textField.isEqual(self.responder) {
      self.responder = textField
    }
    return true
  }
  
  func textFieldShouldReturn (textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    if self.becomeFirstResponderRequiredField() {
      return false
    }
    
    self.kickDidInputedField()
    self.clear()
    return true
  }

}
