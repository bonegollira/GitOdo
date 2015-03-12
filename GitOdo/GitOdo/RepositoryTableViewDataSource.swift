//
//  RepositoryTableViewDataSource.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/09.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class RepositoryTableViewDataSource: NSObject, UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ArchiveConnection.sharedInstance.repositories.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(
      RepositoryTableViewCell.identifier,
      forIndexPath: indexPath
    ) as RepositoryTableViewCell
    
    let repository = ArchiveConnection.sharedInstance.repositories[indexPath.row]
    cell.title = repository.github
    
    return cell
  }
}
