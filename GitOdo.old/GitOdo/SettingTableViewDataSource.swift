//
//  SettingTableViewDataSource.swift
//  GitOdo
//
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit

class SettingTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, SettingTableHeaderViewDelegate {
  
  struct SectionData {
    let name: String
  }
  
  var sectionName: [String] = [
    "REPOSITORY",
    "ACCESS TOKEN"
  ]
  
  weak var delegate: SettingTableViewDelegate?
  
  // MARK: UITableViewDataSource
  
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
      ) as! SettingTableViewCell
    
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
      cell.subtitle = "\(github.account) (\(github.host))"
      cell.isLastCell = isLastCell
    }
    
    return cell
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(
      SettingTableHeaderView.identifier
      ) as! SettingTableHeaderView
    
    headerView.delegate = self
    headerView.section = section
    headerView.sectionName = self.sectionName[section]
    return headerView
  }
  
  // @bridge
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.delegate?.tableView?(tableView, didSelectRowAtIndexPath: indexPath)
  }
  
  // @bridge
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    self.delegate?.tableView?(tableView, didDeselectRowAtIndexPath: indexPath)
  }
  
  // @bridge
  func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    self.delegate?.tableView?(tableView, didEndDisplayingCell: cell, forRowAtIndexPath: indexPath)
  }
  
  // MARK: SettingTableHeaderViewDelegate
  
  // @bridge
  func settingTableHeaderView(headerView: SettingTableHeaderView, didSelectSection section: Int) {
    self.delegate?.settingTableHeaderView?(headerView, didSelectSection: section)
  }
}
