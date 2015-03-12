//
//  RepositoryTableViewComponent.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/09.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class RepositoryTableViewComponent: NSObject {
  
  let view = UITableView()
  let dataSource = RepositoryTableViewDataSource()
  
  override init () {
    super.init()
    self.configure_view()
  }
  
  func configure_view () {
    self.view.dataSource = self.dataSource
    self.view.rowHeight = 44
    self.view.separatorStyle = .None
    self.view.registerClass(
      RepositoryTableViewCell.self,
      forCellReuseIdentifier: RepositoryTableViewCell.identifier
    )
  }
}
