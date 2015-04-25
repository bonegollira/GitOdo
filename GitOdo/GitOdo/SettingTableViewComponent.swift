//
//  SettingTableViewComponent.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/22.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

extension SettingTableViewComponent: ViewComponentsLayout {
  
  func configure__self () {
    self.bounces = false
    self.estimatedRowHeight = 100
    self.rowHeight = UITableViewAutomaticDimension
    self.separatorStyle = .None
    self.registerClass(
      SettingTableViewCell.self,
      forCellReuseIdentifier: SettingTableViewCell.identifier
    )
    self.registerClass(
      SettingTableHeaderView.self,
      forHeaderFooterViewReuseIdentifier: SettingTableHeaderView.identifier
    )
    self.registerClass(
      SettingTableFooterView.self,
      forHeaderFooterViewReuseIdentifier: SettingTableFooterView.identifier
    )
  }
  
  func render (parentView: UIView) {
    parentView.addSubview(self)
    self.configure__self()
  }
}

class SettingTableViewComponent: UITableView, ArchiveConnectionDelegate {
  
  let data = SettingTableViewDataSource()
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init (frame: CGRect) {
    super.init(frame: CGRectZero, style: .Grouped)
    self.dataSource = self.data
    ArchiveConnection.sharedInstance().delegate = self
  }
  
  func didAddedRepository(repository: RepositoryObject, index: Int) {
    self.reloadData()
  }
  
  func didAddedGithub(github: GithubObject, index: Int) {
    self.reloadData()
  }
  
  func didRemovedRepository(repository: RepositoryObject, index: Int) {
    self.reloadData()
  }
  
  func didRemovedGithub(github: GithubObject, index: Int) {
    self.reloadData()
  }
  
}
