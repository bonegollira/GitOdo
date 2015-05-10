//
//  SettingTableViewComponent.swift
//  GitOdo
//
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit
import Cartography

extension SettingTableViewComponent: ViewComponentsLayout {
  
  func configure__tableView () {
    self.tableView.bounces = false
    self.tableView.estimatedRowHeight = 100
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.separatorStyle = .None
    self.tableView.registerClass(
      SettingTableViewCell.self,
      forCellReuseIdentifier: SettingTableViewCell.identifier
    )
    self.tableView.registerClass(
      SettingTableHeaderView.self,
      forHeaderFooterViewReuseIdentifier: SettingTableHeaderView.identifier
    )
  }
  
  func autolayout__tableView () {
    layout(self.tableView) { tableView in
      tableView.edges == tableView.superview!.edges
    }
  }
  
  func render (parentView: UIView) {
    parentView.addSubview(self)
    self.addSubview(self.tableView)
    self.configure__tableView()
    self.autolayout__tableView()
  }
}

protocol SettingTableViewDelegate: UITableViewDelegate, SettingTableHeaderViewDelegate {
}

class SettingTableViewComponent: UIView, ArchiveConnectionDelegate {
  
  weak var delegate: SettingTableViewDelegate? {
    get {
      return self.dataSource.delegate
    }
    set {
      self.dataSource.delegate = newValue
    }
  }
  let dataSource = SettingTableViewDataSource()
  let tableView = UITableView(frame: CGRectZero, style: .Grouped)
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init (frame: CGRect) {
    super.init(frame: CGRectZero)
    self.tableView.dataSource = self.dataSource
    self.tableView.delegate = self.dataSource
    ArchiveConnection.sharedInstance().delegate = self
  }
  
  func cellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell? {
    return self.tableView.cellForRowAtIndexPath(indexPath)
  }
  
  func didAddedRepository(repository: RepositoryObject, index: Int) {
    self.tableView.reloadData()
  }
  
  func didAddedGithub(github: GithubObject, index: Int) {
    self.tableView.reloadData()
  }
  
  func didRemovedRepository(repository: RepositoryObject, index: Int) {
    self.tableView.reloadData()
  }
  
  func didRemovedGithub(github: GithubObject, index: Int) {
    self.tableView.reloadData()
  }
  
}
