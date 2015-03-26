//
//  IssuesTableViewComponent.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

extension TaskTableViewComponent: ViewComponentsLayout {
  
  func configure__self () {
    self.backgroundColor = rgba(230, 230, 230)
    self.separatorStyle = .None
    self.estimatedRowHeight = 65
    self.rowHeight = UITableViewAutomaticDimension
    self.registerClass(
      TaskTableViewCell.self,
      forCellReuseIdentifier: TaskTableViewCell.identifier
    )
    self.registerClass(
      TaskTableViewHeaderView.self,
      forHeaderFooterViewReuseIdentifier: TaskTableViewHeaderView.identifier
    )
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
  }
  
  func render (parentView: UIView) {
    parentView.addSubview(self)
    self.addSubview(self.refreshControl)
    self.sendSubviewToBack(self.refreshControl)
    self.configure__self()
  }
  
}

class TaskTableViewComponent: UITableView, UITableViewDelegate {
  
  let refreshControl = UIRefreshControl()
  let data = TaskTableViewDataSource()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init () {
    super.init(frame: CGRectZero, style: .Plain)
    self.dataSource = self.data
  }
  
  func addRepository(repository: RepositoryObject, issues: [IssueObject]) {
    if issues.count == 0 {
      return
    }
    if !contains(self.data.repositories, repository.owerRepo) {
      self.data.repositories.append(repository.owerRepo)
    }
    self.data.issues[repository.owerRepo] = issues
    self.reloadData()
  }
  
  func addRepository(repository: RepositoryObject, pullRequests: [PullRequestObject]) {
    if pullRequests.count == 0 {
      return
    }
    if !contains(self.data.repositories, repository.owerRepo) {
      self.data.repositories.append(repository.owerRepo)
    }
    self.data.pullRequests[repository.owerRepo] = pullRequests
    self.reloadData()
  }
}
