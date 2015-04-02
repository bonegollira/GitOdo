//
//  IssuesTableViewCell.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

extension TaskTableViewCell: ViewComponentsDequeueLayout {
  
  func configure__self () {
    self.selectionStyle = .Default
  }
  
  func configure__titleLlbel () {
    self.titleLabel.font = UIFont(name: "Helvetica-Bold", size: 13)
    self.titleLabel.textAlignment = .Left
    self.titleLabel.backgroundColor = UIColor.clearColor()
    self.titleLabel.numberOfLines = 0
    self.titleLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
    self.titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__typeIcon () {
    self.typeIcon.textAlignment = .Left
    self.typeIcon.font = UIFont(name: "octicons", size: 18)
    self.typeIcon.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__actionIcon () {
    self.actionIcon.text = "\u{f078}"
    self.actionIcon.textAlignment = .Right
    self.actionIcon.textColor = rgba(200, 200, 200)
    self.actionIcon.font = UIFont(name: "octicons", size: 14)
    self.actionIcon.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout__typeIcon () {
    layout(self.typeIcon) { typeIcon in
      typeIcon.left == typeIcon.superview!.left + 20
      typeIcon.centerY == typeIcon.superview!.centerY
      typeIcon.width == 20
      typeIcon.height == 20
    }
  }
  
  func autolayout__actionIcon () {
    layout(self.actionIcon, self.titleLabel) { actionIcon, titleLabel in
      actionIcon.right == actionIcon.superview!.right - 20
      actionIcon.centerY == actionIcon.superview!.centerY
      actionIcon.width == 20
      actionIcon.height == 20
    }
  }
  func autolayout__titleLabel () {
    layout(self.titleLabel, self.typeIcon, self.actionIcon) { titleLabel, typeIcon, actionIcon in
      titleLabel.left == typeIcon.right + 20
      titleLabel.right == actionIcon.left - 20
      titleLabel.top == titleLabel.superview!.top + 20
      titleLabel.bottom == titleLabel.superview!.bottom - 20 ~ 249
    }
  }
  
  func render () {
    self.contentView.addSubview(self.typeIcon)
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.actionIcon)
    self.configure__self()
    self.configure__titleLlbel()
    self.configure__typeIcon()
    self.configure__actionIcon()
    self.autolayout__titleLabel()
    self.autolayout__typeIcon()
    self.autolayout__actionIcon()
  }
  
}

class TaskTableViewCell: UITableViewCell {
  
  class var identifier: String {
    return "TaskTableViewCell"
  }
  
  var title: String? {
    get {
      return self.titleLabel.text
    }
    set {
      self.titleLabel.text = newValue
    }
  }
  
  var type: String? {
    didSet {
      if type == "issue" {
        self.typeIcon.textColor = rgba(108, 198, 68)
        self.typeIcon.text = "\u{f026}"
      }
      else if type == "pullRequest" {
        self.typeIcon.textColor = rgba(65, 131, 196)
        self.typeIcon.text = "\u{f009}"
      }
    }
  }
  
  var isAtYou: Bool = false {
    didSet {
      if isAtYou {
        self.typeIcon.textColor = rgba(255, 128, 0)
      }
    }
  }
  
  //  var userIconUrl: String? {
  //    didSet {
  //      self.userIconImageView.image = nil
  //
  //      if let urlString = userIconUrl {
  //        GithubConnection.requestGravatar(urlString, { image in
  //          dispatch_async(dispatch_get_main_queue(), {
  //            self.userIconImageView.image = image
  //            self.layoutIfNeeded()
  //          });
  //          })
  //      }
  //    }
  //  }
  
  var isEmptyCell: Bool = false {
    didSet {
      if isEmptyCell {
        self.title = ""
        self.typeIcon.text = ""
        self.actionIcon.hidden = true
        self.contentView.backgroundColor = rgba(230, 230, 230)
        self.userInteractionEnabled = false
      }
      else {
        self.actionIcon.hidden = false
        self.contentView.backgroundColor = rgba(255, 255, 255)
        self.userInteractionEnabled = true
      }
    }
  }
  
  let titleLabel = UILabel()
  let typeIcon = UILabel()
  let actionIcon = UILabel()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.render()
  }
}
