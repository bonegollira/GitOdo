//
//  IssuesTableHeaderView.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/12.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

class IssuesTableHeaderView: UIView {

  let titleLabel = UILabel()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init (title: String) {
    super.init(frame: CGRectZero)
    self.addSubview(self.titleLabel)
    self.configure()
    self.configure_titleLabel(title)
    self.autolayout()
  }
  
  func configure () {
    self.backgroundColor = rgba(236, 168, 59)
  }
  
  func configure_titleLabel (title: String) {
    self.titleLabel.text = title
    self.titleLabel.font = UIFont(name: "Helvetica-Bold", size: 16)
    self.titleLabel.textColor = rgba(0, 0, 0)
  }
  
  func autolayout () {
    layout(self.titleLabel) { titleLabel in
      titleLabel.edges == inset(titleLabel.superview!.edges, 0, 20, 0, 20)
      return
    }
  }

}
