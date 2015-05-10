//
//  IssuesTableViewComponent.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cartography

extension TaskTableViewComponent: ViewComponentsLayout {
  
  func configure__self () {
    self.backgroundColor = rgba(0, 0, 0, a: 0)
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func configure__tableView () {
    self.tableView.backgroundColor = rgba(230, 230, 230)
    self.tableView.separatorStyle = .None
    self.tableView.registerClass(
      TaskTableViewCell.self,
      forCellReuseIdentifier: TaskTableViewCell.identifier
    )
    self.tableView.registerClass(
      TaskTableViewHeaderView.self,
      forHeaderFooterViewReuseIdentifier: TaskTableViewHeaderView.identifier
    )
    self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func autolayout__tableView () {
    layout(self.tableView) { tableView in
      tableView.edges == tableView.superview!.edges
    }
  }
  
  func render (parentView: UIView) {
    parentView.addSubview(self)
    self.addSubview(self.tableView)
    self.tableView.addSubview(self.refreshControl)
    self.tableView.sendSubviewToBack(self.refreshControl)
    self.configure__tableView()
    self.autolayout__tableView()
  }
  
}


protocol TaskTableViewDelegate: UITableViewDelegate, TaskTableViewHeaderViewDelegate {
}

class TaskTableViewComponent: UIView {
  
  weak var delegate: TaskTableViewDelegate? {
    get {
      return self.dataSource.delegate
    }
    set {
      self.dataSource.delegate = newValue
    }
  }
  let dataSource = TaskTableViewDataSource()
  let tableView = UITableView(frame: CGRectZero, style: .Plain)
  let refreshControl = UIRefreshControl()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init () {
    super.init(frame: CGRectZero)
    self.tableView.delegate = self.dataSource
    self.tableView.dataSource = self.dataSource
  }
  
  func reloadData () {
    self.tableView.reloadData()
  }
  
  func addSource (repository: RepositoryObject, type: ToDoType, todos: [protocol<ToDoObjectProtocol>]) {
    self.dataSource.addSource(repository, type: type, todos: todos)
    self.reloadData()
  }
  
  func filterBySearchWord (searchWord: String) {
    self.dataSource.searchWord = searchWord
    self.reloadData()
  }
}
