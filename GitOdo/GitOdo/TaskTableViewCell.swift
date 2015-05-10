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
  
  struct Sizing {
    static var cell: TaskTableViewCell?
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.titleLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.titleLabel.bounds)
    self.issueNumberLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.issueNumberLabel.bounds)
  }
  
  class func height(tableView: UITableView, title: String, issueNumber: Int) -> CGFloat {
    if Sizing.cell == nil {
      Sizing.cell = tableView.dequeueReusableCellWithIdentifier(TaskTableViewCell.identifier) as? TaskTableViewCell
    }
    
    if let cell = Sizing.cell {
      cell.frame.size.width = CGRectGetWidth(tableView.bounds)
      cell.title = title
      cell.issueNumber = issueNumber
      cell.layoutIfNeeded()
      let size = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
      return size.height
    }
    
    return 0.0
  }
  
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
  
  func configure__issueNumberLabel () {
    self.issueNumberLabel.font = UIFont(name: "Helvetica-Bold", size: 10)
    self.issueNumberLabel.textAlignment = .Left
    self.issueNumberLabel.textColor = rgba(150, 150, 150)
    self.issueNumberLabel.backgroundColor = rgba(0, 0, 0, a: 0)
    self.issueNumberLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
    self.issueNumberLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__commentsIcon () {
    self.commentsIcon.text = "\u{f02b}"
    self.commentsIcon.textAlignment = .Right
    self.commentsIcon.textColor = rgba(150, 150, 150)
    self.commentsIcon.font = UIFont(name: "octicons", size: 10)
    self.commentsIcon.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__commentsNumberLabel () {
    self.commentsNumberLabel.font = UIFont(name: "Helvetica-Bold", size: 10)
    self.commentsNumberLabel.textAlignment = .Right
    self.commentsNumberLabel.textColor = rgba(150, 150, 150)
    self.commentsNumberLabel.backgroundColor = rgba(0, 0, 0, a: 0)
    self.commentsNumberLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
    self.commentsNumberLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout__typeIcon () {
    layout(self.typeIcon) { typeIcon in
      typeIcon.left == typeIcon.superview!.left + 20
      typeIcon.top == typeIcon.superview!.top + 15
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
      titleLabel.top == titleLabel.superview!.top + 15
    }
  }
  
  func autolayout__issueNumberLabel () {
    layout(self.issueNumberLabel, self.titleLabel) { issueNumberLabel, titleLabel in
      issueNumberLabel.left == titleLabel.left
      issueNumberLabel.top == titleLabel.bottom + 5
      issueNumberLabel.bottom == issueNumberLabel.superview!.bottom - 15 ~ 250
    }
  }
  
  func autolayout__commentsIcon () {
    layout(self.commentsIcon, self.commentsNumberLabel, self.titleLabel) { commentsIcon, commentsNumberLabel, titleLabel in
      commentsIcon.right == commentsNumberLabel.left - 2
      commentsIcon.top == titleLabel.bottom + 5
      commentsIcon.bottom == commentsIcon.superview!.bottom - 15 ~ 250
    }
  }
  
  func autolayout__commentsNumberLabel () {
    layout(self.commentsNumberLabel, self.titleLabel) { commentsNumberLabel, titleLabel in
      commentsNumberLabel.right == titleLabel.right
      commentsNumberLabel.top == titleLabel.bottom + 5
      commentsNumberLabel.bottom == commentsNumberLabel.superview!.bottom - 15 ~ 250
    }
  }
  
  func render () {
    self.contentView.addSubview(self.typeIcon)
    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.actionIcon)
    self.contentView.addSubview(self.issueNumberLabel)
    self.contentView.addSubview(self.commentsIcon)
    self.contentView.addSubview(self.commentsNumberLabel)
    self.configure__self()
    self.configure__titleLlbel()
    self.configure__typeIcon()
    self.configure__actionIcon()
    self.configure__issueNumberLabel()
    self.configure__commentsIcon()
    self.configure__commentsNumberLabel()
    self.autolayout__titleLabel()
    self.autolayout__typeIcon()
    self.autolayout__actionIcon()
    self.autolayout__issueNumberLabel()
    self.autolayout__commentsIcon()
    self.autolayout__commentsNumberLabel()
  }
  
}

class TaskTableViewCell: UITableViewCell {
  
  class var identifier: String {
    return "TaskTableViewCell"
  }
  
  var title: String {
    get {
      return self.titleLabel.text ?? ""
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
  
  var issueNumber: Int {
    get {
      return self.issueNumberLabel.text?.toInt() ?? 0
    }
    set {
      self.issueNumberLabel.text = "#\(newValue)"
    }
  }
  
  var comments: Int {
    get {
      return self.commentsNumberLabel.text?.toInt() ?? 0
    }
    set {
      let isHidden = newValue == 0
      self.commentsNumberLabel.text = "\(newValue)"
      self.commentsIcon.hidden = isHidden
      self.commentsNumberLabel.hidden = isHidden
    }
  }
  
  let titleLabel = UILabel()
  let typeIcon = UILabel()
  let actionIcon = UILabel()
  let issueNumberLabel = UILabel()
  let commentsIcon = UILabel()
  let commentsNumberLabel = UILabel()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.render()
  }
}
