//
//  SettingTableViewCell.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/22.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

extension SettingTableViewCell: ViewComponentsDequeueLayout {
  
  func configure__self () {
    self.selectionStyle = .None
    self.contentView.backgroundColor = rgba(255, 255, 255)
  }
  
  func configure__titleLabel () {
    self.titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
    self.titleLabel.textAlignment = .Left
    self.titleLabel.backgroundColor = UIColor.clearColor()
    self.titleLabel.numberOfLines = 0
    self.titleLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
    self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__subtitleLabel () {
    self.subtitleLabel.font = UIFont(name: "HelveticaNeue", size: 9)
    self.subtitleLabel.numberOfLines = 0
    self.subtitleLabel.textColor = UIColor.grayColor()
    self.subtitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__deleteIcon () {
    self.deleteIcon.alpha = 0.0
    self.deleteIcon.text = "\u{f081}"
    self.deleteIcon.font = UIFont(name: "octicons", size: 18)
    self.deleteIcon.textAlignment = .Right
    self.deleteIcon.textColor = rgba(255, 0, 0)
    self.deleteIcon.backgroundColor = rgba(255, 255, 255)
    self.deleteIcon.userInteractionEnabled = true
    self.deleteIcon.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__bottomBorder () {
    self.bottomBorder.backgroundColor = rgba(225, 225, 225)
    self.bottomBorder.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout__titleLabel () {
    layout(self.titleLabel) { titleLabel in
      titleLabel.left == titleLabel.superview!.left + 20
      titleLabel.right == titleLabel.superview!.right - 20
      titleLabel.top == titleLabel.superview!.top + 15
      titleLabel.bottom == (titleLabel.superview!.bottom - 15) ~ 249
    }
  }
  
  func autolayout__subtitleLabel () {
    layout(self.subtitleLabel, self.titleLabel) { subtitleLabel, titleLabel in
      subtitleLabel.top == titleLabel.bottom
      subtitleLabel.bottom == (subtitleLabel.superview!.bottom - 15) ~ 250
      subtitleLabel.left == titleLabel.left
      subtitleLabel.width == titleLabel.width
    }
  }
  
  func autolayout__bottomBorder () {
    layout(self.bottomBorder) { bottomBorder in
      bottomBorder.centerX == bottomBorder.superview!.centerX
      bottomBorder.bottom == bottomBorder.superview!.bottom
      bottomBorder.width == bottomBorder.superview!.width - 40
      bottomBorder.height == 1
    }
  }
  
  func autolayout__deleteIcon () {
    layout(self.deleteIcon) { deleteIcon in
      deleteIcon.right == deleteIcon.superview!.right - 20
      deleteIcon.centerY == deleteIcon.superview!.centerY
      deleteIcon.width == 30
    }
  }
  
  func render () {
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.subtitleLabel)
    self.contentView.addSubview(self.deleteIcon)
    self.contentView.addSubview(self.bottomBorder)
    self.configure__self()
    self.configure__titleLabel()
    self.configure__subtitleLabel()
    self.configure__deleteIcon()
    self.configure__bottomBorder()
    self.autolayout__titleLabel()
    self.autolayout__subtitleLabel()
    self.autolayout__deleteIcon()
    self.autolayout__bottomBorder()
  }
  
}

class SettingTableViewCell: UITableViewCell {
  
  class var identifier: String {
    return "SettingTableViewCell"
  }
  
  let titleLabel = UILabel()
  let subtitleLabel = UILabel ()
  let deleteIcon = UILabel()
  let bottomBorder = UIView()
  
  var title: String? {
    get {
      return self.titleLabel.text
    }
    set {
      self.titleLabel.text = newValue
    }
  }
  
  var subtitle: String? {
    get {
      return self.subtitleLabel.text
    }
    set {
      self.subtitleLabel.text = newValue
    }
  }
  
  var isLastCell: Bool = false {
    didSet {
      self.bottomBorder.hidden = isLastCell
    }
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.render()
  }
  
}
