//
//  IssuesTableHeaderView.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/12.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

extension TaskTableViewHeaderView: ViewComponentsDequeueLayout {
  
  func configure__self () {
    self.contentView.backgroundColor = rgba(44, 93, 142)
  }
  
   func configure__repositoryNameLabel () {
    self.repositoryLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
    self.repositoryLabel.textColor = rgba(255, 255, 255)
    self.repositoryLabel.textAlignment = .Left
    self.repositoryLabel.userInteractionEnabled = true
    self.repositoryLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
   func configure__rowCountLabel () {
    self.rowCountLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
    self.rowCountLabel.textColor = rgba(255, 255, 255)
    self.rowCountLabel.textAlignment = .Right
    self.rowCountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__addIcon () {
    self.addIcon.text = "\u{f05d}"
    self.addIcon.font = UIFont(name: "octicons", size: 12)
    self.addIcon.textColor = rgba(255, 255, 255)
    self.addIcon.textAlignment = .Right
    self.addIcon.userInteractionEnabled = true
    self.addIcon.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout__repositoryNameLabel () {
    layout(self.repositoryLabel, self.rowCountLabel) { repositoryNameLabel, rowCountLabel in
      repositoryNameLabel.left == repositoryNameLabel.superview!.left + 20 ~ 250
      repositoryNameLabel.right == rowCountLabel.left ~ 249
      repositoryNameLabel.top == repositoryNameLabel.superview!.top
      repositoryNameLabel.bottom == repositoryNameLabel.superview!.bottom
    }
  }
  
  func autolayout__rowCountLabel () {
    layout(self.rowCountLabel, self.addIcon) { rowCountLabel, addIcon in
      rowCountLabel.right == addIcon.left + 20
      rowCountLabel.top == rowCountLabel.superview!.top
      rowCountLabel.bottom == rowCountLabel.superview!.bottom
    }
  }
  
  func autolayout__addIcon () {
    layout(self.addIcon) { addIcon in
      addIcon.right == addIcon.superview!.right - 20 ~ 250
      addIcon.width == 44
      addIcon.height == 44
    }
  }
  
  func render () {
    self.contentView.addSubview(self.repositoryLabel)
    self.contentView.addSubview(self.rowCountLabel)
    self.contentView.addSubview(self.addIcon)
    self.configure__self()
    self.configure__rowCountLabel()
    self.configure__repositoryNameLabel()
    self.configure__addIcon()
    self.autolayout__rowCountLabel()
    self.autolayout__repositoryNameLabel()
    self.autolayout__addIcon()
  }
  
}

@objc protocol TaskTableViewHeaderViewDelegate: NSObjectProtocol {
  optional func taskTableViewHeaderView(headerView: TaskTableViewHeaderView, didSelectSection section: Int)
  optional func taskTableViewHeaderView(headerView: TaskTableViewHeaderView, didSelectAdd section: Int)
}

class TaskTableViewHeaderView: UITableViewHeaderFooterView {

  class var identifier: String {
    return "TaskTableViewHeaderView"
  }
  
  weak var delegate: TaskTableViewHeaderViewDelegate?

  let repositoryLabel = UILabel()
  let rowCountLabel = UILabel()
  let addIcon = UILabel()
  var repository: RepositoryObject? {
    didSet {
      self.repositoryLabel.text = repository?.owerRepo
    }
  }
  var rowCount: Int = 0 {
    didSet {
      self.rowCountLabel.text = "\(rowCount)"
    }
  }
  var section: Int = 0
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    self.render()
    self.repositoryLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didSelectSection:"))
    self.addIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didSelectAdd:"))
  }
  
  // MARK: TaskTableViewHeaderViewDelegate
  
  func didSelectSection (sender: UITapGestureRecognizer) {
    self.delegate?.taskTableViewHeaderView?(self, didSelectSection: self.section)
  }
  
  func didSelectAdd (sender: UITapGestureRecognizer) {
    self.delegate?.taskTableViewHeaderView?(self, didSelectAdd: self.section)
  }
}
