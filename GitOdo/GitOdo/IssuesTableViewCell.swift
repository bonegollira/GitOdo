//
//  IssuesTableViewCell.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

@IBDesignable class IssuesTableViewCell: UITableViewCell {
  
  class var identifier: String {
    return "IssuesTableViewCell"
  }
  
  var title: String? {
    get {
      return self.titleLabel.text
    }
    set {
      self.titleLabel.text = newValue
    }
  }
  
  var number: Int? {
    get {
      return self.numberLabel.text?.toInt()
    }
    set {
      self.numberLabel.text = "#\(newValue!)"
    }
  }
  
  var user: String? {
    get {
      return self.userLabel.text
    }
    set {
      self.userLabel.text = "@\(newValue!)"
    }
  }
  
  private let titleLabel = UILabel()
  private let numberLabel = UILabel()
  private let userLabel = UILabel()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.numberLabel)
    self.contentView.addSubview(self.userLabel)
    self.configure()
    self.configure_titleLlbel()
    self.configure_numberLabel()
    self.configure_userLabel()
    self.autolayout()
  }
  
  func configure () {
  }
  
  func configure_titleLlbel () {
    self.titleLabel.font = UIFont(name: "Helvetica", size: 12)
    self.titleLabel.textAlignment = .Left
    self.titleLabel.backgroundColor = UIColor.clearColor()
    self.titleLabel.numberOfLines = 0
    self.titleLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
    self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure_numberLabel () {
    self.numberLabel.font = UIFont(name: "HelveticaNeue", size: 9)
    self.numberLabel.textAlignment = .Left
    self.numberLabel.textColor = UIColor.grayColor()
    self.numberLabel.backgroundColor = UIColor.clearColor()
    self.numberLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure_userLabel () {
    self.userLabel.font = UIFont(name: "HelveticaNeue", size: 9)
    self.userLabel.textAlignment = .Left
    self.userLabel.textColor = UIColor.grayColor()
    self.userLabel.backgroundColor = UIColor.clearColor()
    self.userLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout () {
    layout(self.titleLabel) { titleLabel in
      titleLabel.edges == inset(titleLabel.superview!.edges, 20, 20, 40, 20)
      return
    }
    layout(self.numberLabel, self.titleLabel) { numberLabel, titleLabel in
      numberLabel.left == titleLabel.left
      numberLabel.top == titleLabel.bottom
      numberLabel.width == 20
      numberLabel.height == 20
    }
    layout(self.userLabel, self.numberLabel) { userLabel, numberLabel in
      userLabel.left == numberLabel.right
      userLabel.top == numberLabel.top
//      userLabel.width == titleLabel.width - 20
      userLabel.height == 20
    }
  }
}
