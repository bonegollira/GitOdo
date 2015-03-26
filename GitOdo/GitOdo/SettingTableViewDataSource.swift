//
//  SettingTableViewDataSource.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/22.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class SettingTableViewDataSource: NSObject, UITableViewDataSource {
  
  struct SectionData {
    let name: String
    var tapGesture: UITapGestureRecognizer
  }
  
  var sectionData = [
    SectionData(name: "REPOSITORY", tapGesture: UITapGestureRecognizer()),
    SectionData(name: "ACCESS TOKEN", tapGesture: UITapGestureRecognizer())
  ]
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return ArchiveConnection.sharedInstance().repositories.count
    }
    if section == 1 {
      return ArchiveConnection.sharedInstance().githubs.count
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(
      SettingTableViewCell.identifier,
      forIndexPath: indexPath
      ) as SettingTableViewCell
    
    if indexPath.section == 0 {
      let repositories = ArchiveConnection.sharedInstance().repositories
      let repository = repositories[indexPath.row]
      let isLastCell = (indexPath.row + 1) == repositories.count
      cell.title = repository.owerRepo
      cell.subtitle = repository.host
      cell.isLastCell = isLastCell
    }
    if indexPath.section == 1 {
      let githubs = ArchiveConnection.sharedInstance().githubs
      let github = githubs[indexPath.row]
      let isLastCell = (indexPath.row + 1) == githubs.count
      cell.title = github.accessToken
      cell.subtitle = github.host
      cell.isLastCell = isLastCell
    }
    
    return cell
  }
  
}
