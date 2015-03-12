//
//  IssuesTableViewDataSource.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class IssuesTableViewDataSource: NSObject, UITableViewDataSource {
  
  var repositories = [String]()
  var issues = [String: [IssueObject]]()
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.repositories.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let repository = self.repositories[section]
    if let count = self.issues[repository]?.count {
      return count
    }
    return 0
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.repositories[section]
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(
      IssuesTableViewCell.identifier,
      forIndexPath: indexPath
    ) as IssuesTableViewCell
    
    let repository = self.repositories[indexPath.section]
    if let issue = self.issues[repository]?[indexPath.row] {
      cell.title = issue.title
      cell.number = issue.number
      cell.user = issue.user.login
    }
    
    return cell
  }

}
