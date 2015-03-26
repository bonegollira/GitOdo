//
//  SettingTableHeaderView.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/22.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

extension SettingTableHeaderView: ViewComponentsDequeueLayout {
  
  func configure__self () {
    self.contentView.backgroundColor = rgba(0, 0, 0, a:0)
  }
  
  func configure__titleLabel () {
    self.titleLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
    self.titleLabel.textColor = rgba(44, 93, 142)
    self.titleLabel.textAlignment = .Left
    self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout__titleLabel () {
    layout(self.titleLabel) { titleLabel in
      titleLabel.left == (titleLabel.superview!.left + 20) ~ 250
      titleLabel.right == (titleLabel.superview!.right - 20) ~ 250
      titleLabel.bottom == titleLabel.superview!.bottom - 5
    }
  }
  
  func render () {
    self.contentView.addSubview(self.titleLabel)
    self.configure__titleLabel()
    self.autolayout__titleLabel()
  }
  
}

class SettingTableHeaderView: UITableViewHeaderFooterView {
  
  class var identifier: String {
    return "SettingTableHeaderView"
  }
  let titleLabel = UILabel()
  var sectionName: String? {
    get {
      return self.titleLabel.text
    }
    set {
      self.titleLabel.text = newValue
    }
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.render()
  }
  
}
