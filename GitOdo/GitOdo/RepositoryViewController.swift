//
//  RepositoryViewController.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/08.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

class RepositoryViewController: UIViewController, UITableViewDelegate, RepositoryFieldViewDelegate {
  
  let addButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: nil, action: "")
  let fieldViewComponent = RepositoryFieldViewComponent()
  let tableViewComponent = RepositoryTableViewComponent()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configure()
    self.configure_addButtonItem()
    self.configure_fieldViewComponent()
    self.configure_tableViewComponent()
    self.navigationItem.rightBarButtonItem = self.addButtonItem
    self.view.addSubview(self.fieldViewComponent.view)
    self.view.addSubview(self.tableViewComponent.view)
  }
  
  func configure () {
    self.title = "Repositories"
    self.view.backgroundColor = UIColor.whiteColor()
  }
  
  func configure_addButtonItem () {
    self.addButtonItem.target = self
    self.addButtonItem.action = "beInputMode:"
  }
  
  func configure_fieldViewComponent () {
    self.fieldViewComponent.delegate = self
    self.fieldViewComponent.view.hidden = true
  }
  
  func configure_tableViewComponent () {
    self.tableViewComponent.view.delegate = self
  }
  
  override func viewDidLayoutSubviews() {
    layout(self.fieldViewComponent.view) { fieldView in
      fieldView.left == fieldView.superview!.left
      fieldView.right == fieldView.superview!.right
      fieldView.top == fieldView.superview!.top + 64
      fieldView.height == 132
    }
    layout(self.tableViewComponent.view) { tableView in
      let navBarHeight = self.navigationController?.navigationBar.bounds.size.height
      tableView.left == tableView.superview!.left
      tableView.right == tableView.superview!.right
      tableView.top == tableView.superview!.top + 64
      tableView.bottom == tableView.superview!.bottom
    }
  }
  
  func beInputMode (sender: UIBarButtonItem) {
    self.tableViewComponent.view.hidden = true
    self.fieldViewComponent.view.hidden = false
    self.fieldViewComponent.start()
  }
  
  func didInputedRepository(repository: RepositoryObject) {
    self.tableViewComponent.view.hidden = false
    ArchiveConnection.sharedInstance.add(repository)
    self.tableViewComponent.view.reloadData()
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let repository = ArchiveConnection.sharedInstance.repositories[indexPath.row]
    ArchiveConnection.sharedInstance.remove(repository)
    self.tableViewComponent.view.reloadData()
  }
}
