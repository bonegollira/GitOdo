//
//  RepositoryFieldViewComponent.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/09.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

protocol RepositoryFieldViewDelegate {
  func didInputedRepository(repository: RepositoryObject)
}

class RepositoryFieldViewComponent: NSObject, UITextFieldDelegate {
  
  var delegate: RepositoryFieldViewDelegate?
  let view = UIView()
  let owerField = UITextField()
  let repositoryField = UITextField()
  let enterpriseField = UITextField()
  let bottomBorder = UIView()
  
  var responder: UITextField? {
    didSet {
      responder?.becomeFirstResponder()
    }
  }
  
  override init () {
    super.init()
    self.view.addSubview(self.owerField)
    self.view.addSubview(self.repositoryField)
    self.view.addSubview(self.enterpriseField)
    self.view.addSubview(self.bottomBorder)
    self.configure()
    self.configure_owerField()
    self.configure_repositoryField()
    self.configure_enterpriseField()
    self.configure_bottomBorder()
    self.autolayout()
  }
  
  func configure () {
    self.view.backgroundColor = UIColor.whiteColor()
  }
  
  func configure_owerField () {
    self.owerField.delegate = self
    self.owerField.placeholder = "user or organization"
    self.owerField.clearButtonMode = .Always
    self.owerField.font = UIFont(name: "HelveticaNeue", size: 12)
  }
  
  func configure_repositoryField () {
    self.repositoryField.delegate = self
    self.repositoryField.placeholder = "repository"
    self.repositoryField.clearButtonMode = .Always
    self.repositoryField.font = UIFont(name: "HelveticaNeue", size: 12)
  }
  
  func configure_enterpriseField () {
    self.enterpriseField.delegate = self
    self.enterpriseField.placeholder = "(https://api.github.com/)"
    self.enterpriseField.clearButtonMode = .Always
    self.enterpriseField.font = UIFont(name: "HelveticaNeue", size: 12)
  }
  
  func configure_bottomBorder () {
    self.bottomBorder.backgroundColor = rgba(225, 225, 225)
    self.bottomBorder.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout () {
    layout(self.owerField) { owerField in
      owerField.centerX == owerField.superview!.centerX
      owerField.top == owerField.superview!.top
      owerField.width == owerField.superview!.width - 40
      owerField.height == 44
    }
    layout(self.repositoryField, self.owerField) { repositoryField, owerField in
      repositoryField.centerX == repositoryField.superview!.centerX
      repositoryField.top == owerField.bottom
      repositoryField.width == repositoryField.superview!.width - 40
      repositoryField.height == 44
    }
    layout(self.enterpriseField, self.repositoryField) { enterpriseField, repositoryField in
      enterpriseField.centerX == enterpriseField.superview!.centerX
      enterpriseField.top == repositoryField.bottom
      enterpriseField.width == enterpriseField.superview!.width - 40
      enterpriseField.height == 44
    }
    layout(self.bottomBorder) { bottomBorder in
      bottomBorder.centerX == bottomBorder.superview!.centerX
      bottomBorder.bottom == bottomBorder.superview!.bottom - 1
      bottomBorder.width == bottomBorder.superview!.width
      bottomBorder.height == 1
    }
  }
  
  func start () {
    self.responder = self.owerField
  }
  
  func clear () {
    self.responder = nil
    self.owerField.text = nil
    self.repositoryField.text = nil
    self.enterpriseField.text = nil
  }
  
  func createRepositoryFromField () -> RepositoryObject {
    let ower = self.owerField.text
    let repo = self.repositoryField.text
    let enterprise = self.enterpriseField.text
    self.clear()
    return RepositoryObject(
      root: !enterprise.isEmpty ? enterprise : RepositoryObject.defaultApi,
      ower: ower,
      repo: repo
    )
  }
  
  func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    if textField != self.responder {
      self.responder = textField
    }
    return true
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if (self.owerField.text.isEmpty) {
      self.owerField.becomeFirstResponder()
    }
    else if (self.repositoryField.text.isEmpty) {
      self.repositoryField.becomeFirstResponder()
    }
    else {
      textField.resignFirstResponder()
      let repository = self.createRepositoryFromField()
      self.delegate?.didInputedRepository(repository)
      return true
    }
    return false
  }
}
