//
//  RepositoryTableViewCell.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/09.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

class RepositoryTableViewCell: UITableViewCell {
  
  class var identifier: String {
    return "RepositoryTableViewCell"
  }
  
  var title: String? {
    get {
      return self.titleLabel.text
    }
    set {
      self.titleLabel.text = newValue
    }
  }
  
  private let titleLabel = UILabel()
  private let bottomBorder = UIView()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.bottomBorder)
    self.configure()
    self.configure_titleLabel()
    self.configure_bottomBorder()
    self.autolayout()
  }
  
  func configure () {
//    self.contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure_titleLabel () {
    self.titleLabel.font = UIFont(name: "HelveticaNeue", size: 12)
    self.titleLabel.textAlignment = .Left
    self.titleLabel.backgroundColor = UIColor.clearColor()
    self.titleLabel.numberOfLines = 0
    self.titleLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
    self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure_bottomBorder () {
    self.bottomBorder.backgroundColor = rgba(225, 225, 225)
    self.bottomBorder.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout () {
    layout(self.titleLabel) { titleLabel in
      titleLabel.centerX == titleLabel.superview!.centerX
      titleLabel.centerY == titleLabel.superview!.centerY
      titleLabel.width == titleLabel.superview!.width - 40
      titleLabel.height == titleLabel.superview!.height - 30
    }
    layout(self.bottomBorder) { bottomBorder in
      bottomBorder.centerX == bottomBorder.superview!.centerX
      bottomBorder.bottom == bottomBorder.superview!.bottom - 1
      bottomBorder.width == bottomBorder.superview!.width - 40
      bottomBorder.height == 1
    }
  }

}
