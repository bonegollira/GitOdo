//
//  SettingTableHeaderView.swift
//  GitOdo
//
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit
import Cartography

extension SettingTableHeaderView: ViewComponentsDequeueLayout {
  
  func configure__self () {
    self.contentView.backgroundColor = rgba(0, g: 0, b: 0, a:0)
  }
  
  func configure__titleLabel () {
    self.titleLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
    self.titleLabel.textColor = rgba(44, g: 93, b: 142)
    self.titleLabel.textAlignment = .Left
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func configure__addIcon () {
    self.addIcon.text = "\u{f05d}"
    self.addIcon.font = UIFont(name: "octicons", size: 12)
    self.addIcon.textAlignment = .Center
    self.addIcon.userInteractionEnabled = true
    self.addIcon.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func autolayout__titleLabel () {
    constrain(self.titleLabel) { titleLabel in
      titleLabel.left == (titleLabel.superview!.left + 20) ~ 250
      titleLabel.right == (titleLabel.superview!.right - 20) ~ 250
      titleLabel.bottom == titleLabel.superview!.bottom - 5
    }
  }
  
  func autolayout__addIcon () {
    constrain(self.addIcon) { addIcon in
      addIcon.right == addIcon.superview!.right - 20
      addIcon.bottom == addIcon.superview!.bottom - 5
      addIcon.width == 18
      addIcon.height == 18
    }
  }
  
  func render () {
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.addIcon)
    self.configure__titleLabel()
    self.configure__addIcon()
    self.autolayout__titleLabel()
    self.autolayout__addIcon()
  }
  
}

@objc protocol SettingTableHeaderViewDelegate: NSObjectProtocol {
  optional func settingTableHeaderView(headerView: SettingTableHeaderView, didSelectSection section: Int)
}

class SettingTableHeaderView: UITableViewHeaderFooterView {
  
  class var identifier: String {
    return "SettingTableHeaderView"
  }
  weak var delegate: SettingTableHeaderViewDelegate?
  let titleLabel = UILabel()
  let addIcon = UILabel()
  var section: Int = 0
  var sectionName: String? {
    get {
      return self.titleLabel.text
    }
    set {
      self.titleLabel.text = newValue
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
 
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.render()
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapped:"))
  }
  
  func tapped (sender: UITapGestureRecognizer) {
    self.delegate?.settingTableHeaderView?(self, didSelectSection: self.section)
  }
}
