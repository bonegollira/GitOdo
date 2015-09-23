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
    self.contentView.backgroundColor = rgba(44, g: 93, b: 142)
  }
  
   func configure__repositoryNameLabel () {
    self.repositoryLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
    self.repositoryLabel.textColor = rgba(255, g: 255, b: 255)
    self.repositoryLabel.textAlignment = .Left
    self.repositoryLabel.userInteractionEnabled = true
    self.repositoryLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
   func configure__rowCountLabel () {
    self.rowCountLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
    self.rowCountLabel.textColor = rgba(255, g: 255, b: 255)
    self.rowCountLabel.textAlignment = .Right
    self.rowCountLabel.userInteractionEnabled = true
    self.rowCountLabel.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func autolayout__repositoryNameLabel () {
    constrain(self.repositoryLabel, self.rowCountLabel) { repositoryNameLabel, rowCountLabel in
      repositoryNameLabel.left == repositoryNameLabel.superview!.left + 20 ~ 250
      repositoryNameLabel.right == rowCountLabel.left - 5 ~ 249
      repositoryNameLabel.top == repositoryNameLabel.superview!.top
      repositoryNameLabel.bottom == repositoryNameLabel.superview!.bottom
    }
  }
  
  func autolayout__rowCountLabel () {
    constrain(self.rowCountLabel) { rowCountLabel in
      rowCountLabel.right == rowCountLabel.superview!.right - 20 ~ 250
      rowCountLabel.top == rowCountLabel.superview!.top
      rowCountLabel.bottom == rowCountLabel.superview!.bottom
      rowCountLabel.width == 44
    }
  }
  
  func render () {
    self.contentView.addSubview(self.repositoryLabel)
    self.contentView.addSubview(self.rowCountLabel)
    self.configure__self()
    self.configure__rowCountLabel()
    self.configure__repositoryNameLabel()
    self.autolayout__rowCountLabel()
    self.autolayout__repositoryNameLabel()
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
  var repository: RepositoryObject? {
    didSet {
      self.repositoryLabel.text = repository?.owerRepo
    }
  }
  var rowCount: Int = 0 {
    didSet {
      self.rowCountLabel.text = "\(rowCount)"
      self.isEmpty = rowCount == 0
    }
  }
  var section: Int = 0
  var isEmpty = false {
    didSet {
      if isEmpty {
        self.contentView.backgroundColor = rgba(44, g: 93, b: 142, a: 0)
      }
      else {
        self.contentView.backgroundColor = rgba(44, g: 93, b: 142)
      }
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
    self.repositoryLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didSelectSection:"))
    self.rowCountLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didSelectAdd:"))
  }
  
  // MARK: TaskTableViewHeaderViewDelegate
  
  func didSelectSection (sender: UITapGestureRecognizer) {
    self.delegate?.taskTableViewHeaderView?(self, didSelectSection: self.section)
  }
  
  func didSelectAdd (sender: UITapGestureRecognizer) {
    self.delegate?.taskTableViewHeaderView?(self, didSelectAdd: self.section)
  }
}
