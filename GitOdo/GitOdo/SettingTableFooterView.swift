//
//  SettingTableFooterView.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/25.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

extension SettingTableFooterView: ViewComponentsDequeueLayout {
  
  func configure__self () {
    self.contentView.backgroundColor = rgba(0, 0, 0, a:0)
  }
  
  func configure__addButton () {
    self.addIcon.text = "\u{f05d}"
    self.addIcon.font = UIFont(name: "octicons", size: 12)
    self.addIcon.textAlignment = .Center
    self.addIcon.userInteractionEnabled = true
    self.addIcon.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout__addButton () {
    layout(self.addIcon) { addButton in
      addButton.edges == addButton.superview!.edges
      return
    }
  }
  
  func render () {
    self.contentView.addSubview(self.addIcon)
    self.configure__addButton()
    self.autolayout__addButton()
  }
  
}

class SettingTableFooterView: UITableViewHeaderFooterView {
  
  class var identifier: String {
    return "SettingTableFooterView"
  }
  let addIcon = UILabel()
  
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
