//
//  IssuesTableViewComponent.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

class IssuesTableViewComponent: NSObject, UITableViewDelegate {
  
  let view = UITableView()
  let dataSource = IssuesTableViewDataSource()
  
  override init () {
    super.init()
    self.configure_view()
    self.configure_dataSource()
  }
  
  func configure_view () {
    self.view.delegate = self
    self.view.dataSource = self.dataSource
    self.view.separatorStyle = .None
    self.view.estimatedRowHeight = 80
    self.view.rowHeight = UITableViewAutomaticDimension
    self.view.registerClass(
      IssuesTableViewCell.self,
      forCellReuseIdentifier: IssuesTableViewCell.identifier
    )
  }
  
  func configure_dataSource () {
  }
  
  func addRepository(repository: RepositoryObject, issues: [IssueObject]) {
    if !contains(self.dataSource.repositories, repository.github) {
      self.dataSource.repositories.append(repository.github)
    }
    self.dataSource.issues[repository.github] = issues
    self.view.reloadData()
  }
  
  func cleaning () {
    let repositories = ArchiveConnection.sharedInstance.repositories.map({ $0.github })
    self.dataSource.repositories = self.dataSource.repositories.filter({ contains(repositories, $0) })
    for github in self.dataSource.issues.keys {
      if !contains(repositories, github) {
        self.dataSource.issues.removeValueForKey(github)
      }
    }
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 35
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return IssuesTableHeaderView(title: self.dataSource.repositories[section])
  }
}
