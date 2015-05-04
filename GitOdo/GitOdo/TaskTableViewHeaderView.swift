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
    self.repositoryNameLabel.font = UIFont(name: "Helvetica-Bold", size: 12)
    self.repositoryNameLabel.textColor = rgba(255, 255, 255)
    self.repositoryNameLabel.textAlignment = .Left
    self.repositoryNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
   func configure__rowCountLabel () {
    self.rowCountLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
    self.rowCountLabel.textColor = rgba(255, 255, 255)
    self.rowCountLabel.textAlignment = .Right
    self.rowCountLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout__rowCountLabel () {
    layout(self.rowCountLabel) { rowCountLabel in
      rowCountLabel.right == (rowCountLabel.superview!.right - 20) ~ 250
      rowCountLabel.top == rowCountLabel.superview!.top
      rowCountLabel.bottom == rowCountLabel.superview!.bottom
    }
  }
  
  func autolayout__repositoryNameLabel () {
    layout(self.repositoryNameLabel) { repositoryNameLabel in
      repositoryNameLabel.left == (repositoryNameLabel.superview!.left + 20) ~ 250
      repositoryNameLabel.right == (repositoryNameLabel.superview!.right - 20) ~ 250
      repositoryNameLabel.top == repositoryNameLabel.superview!.top
      repositoryNameLabel.bottom == repositoryNameLabel.superview!.bottom
    }
  }
  
  func render () {
    self.contentView.addSubview(self.repositoryNameLabel)
    self.contentView.addSubview(self.rowCountLabel)
    self.configure__self()
    self.configure__rowCountLabel()
    self.configure__repositoryNameLabel()
    self.autolayout__rowCountLabel()
    self.autolayout__repositoryNameLabel()
  }
  
}

protocol TaskTableViewHeaderViewDelegate: NSObjectProtocol {
  func taskTableViewHeaderView(headerView: TaskTableViewHeaderView, didSelectSection section: Int)
}

class TaskTableViewHeaderView: UITableViewHeaderFooterView {

  class var identifier: String {
    return "TaskTableViewHeaderView"
  }
  
  weak var delegate: TaskTableViewHeaderViewDelegate?

  let repositoryNameLabel = UILabel()
  let rowCountLabel = UILabel()
  var repositoryName: String {
    get {
      return self.repositoryNameLabel.text ?? ""
    }
    set {
      self.repositoryNameLabel.text = newValue
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
    self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didSelectSection:"))
  }
  
  // MARK: TaskTableViewHeaderViewDelegate
  
  func didSelectSection (sender: UITapGestureRecognizer) {
    self.delegate?.taskTableViewHeaderView(self, didSelectSection: self.section)
  }
}
