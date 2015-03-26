//
//  RepositoryViewController.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/08.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Cartography

extension SettingViewController: ViewControllerLayout {
  
  func configure__self () {
    self.title = "Setting"
  }
  
  func configure__view () {
    self.view.backgroundColor = UIColor.whiteColor()
  }
  
  func configure__addRepositoryField () {
    self.addRepositoryFieldComponent.hidden = true
  }
  
  func configure__addGithubField () {
    self.addGithubFieldComponent.hidden = true
  }
  
  func autolayout__addRepositoryField () {
    layout(self.addRepositoryFieldComponent) { addRepositoryField in
      addRepositoryField.left == addRepositoryField.superview!.left
      addRepositoryField.right == addRepositoryField.superview!.right
      addRepositoryField.top == addRepositoryField.superview!.top
      addRepositoryField.height == 132
    }
  }
  
  func autolayout__addGithubField () {
    layout(self.addGithubFieldComponent) { addGithubField in
      addGithubField.left == addGithubField.superview!.left
      addGithubField.right == addGithubField.superview!.right
      addGithubField.top == addGithubField.superview!.top
      addGithubField.height == 88
    }
  }
  
  func autolayout__tableView () {
    layout(self.tableViewComponent) { tableView in
      tableView.edges == tableView.superview!.edges
      return
    }
  }
  
  func render () {
    self.addRepositoryFieldComponent.render(self.view)
    self.addGithubFieldComponent.render(self.view)
    self.tableViewComponent.render(self.view)
    self.configure__self()
    self.configure__view()
    self.configure__addRepositoryField()
    self.configure__addGithubField()
    self.autolayout__addRepositoryField()
    self.autolayout__addGithubField()
    self.autolayout__tableView()
  }
  
}

class SettingViewController: UIViewController, UITableViewDelegate, SomeFieldViewDelegate {
  
  let tableViewComponent = SettingTableViewComponent()
  let addRepositoryFieldComponent = SomeTextFieldComponent(configures: [
    SomeTextFieldConfigure(id: "ower", placeholder: "user or organization", required: true),
    SomeTextFieldConfigure(id: "repository", placeholder: "repository", required: true),
    SomeTextFieldConfigure(id: "enterprise", placeholder: "(https://api.github.com/)", required: false)
    ])
  let addGithubFieldComponent = SomeTextFieldComponent(configures: [
    SomeTextFieldConfigure(id: "accessToken", placeholder: "access token", required: true),
    SomeTextFieldConfigure(id: "host", placeholder: "(github.com)", required: false)
    ])
  var tapGestureForRemoveArchive = UITapGestureRecognizer()
  var selectingIndexPath: NSIndexPath? {
    willSet {
      if let indexPath = selectingIndexPath {
        self.unbindRemoveButton(indexPath)
      }
    }
    didSet {
      if let indexPath = selectingIndexPath {
        self.bindRemoveButton(indexPath)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableViewComponent.delegate = self
    self.addRepositoryFieldComponent.delegate = self
    self.addGithubFieldComponent.delegate = self
    self.tapGestureForRemoveArchive = UITapGestureRecognizer(target: self, action: "removeArchive:")
    self.tableViewComponent.data.sectionData[0].tapGesture = UITapGestureRecognizer(target: self, action: "beAddingRepository:")
    self.tableViewComponent.data.sectionData[1].tapGesture = UITapGestureRecognizer(target: self, action: "beAddingGithub:")
    self.render()
  }
  
  func beTableViewing () {
    self.addRepositoryFieldComponent.hidden = true
    self.addGithubFieldComponent.hidden = true
    self.tableViewComponent.hidden = false
  }
  
  func beAddingRepository (sender: UITapGestureRecognizer) {
    self.tableViewComponent.hidden = true
    self.addRepositoryFieldComponent.hidden = false
    self.addRepositoryFieldComponent.becomeFirstResponder()
  }
  
  func beAddingGithub (sender: UITapGestureRecognizer) {
    self.tableViewComponent.hidden = true
    self.addGithubFieldComponent.hidden = false
    self.addGithubFieldComponent.becomeFirstResponder()
  }
  
  func didInputedField(component: SomeTextFieldComponent, texts: [String : String]) {
    if component.isEqual(self.addRepositoryFieldComponent) {
      ArchiveConnection.sharedInstance().addRepository(
        texts["ower"]!,
        repo: texts["repository"]!,
        enterprise: texts["enterprise"]!
      )
      self.addRepositoryFieldComponent.hidden = true
      self.tableViewComponent.hidden = false
    }
    if component.isEqual(self.addGithubFieldComponent) {
      ArchiveConnection.sharedInstance().addGithub(
        texts["accessToken"]!,
        host: texts["host"]!
      )
    }
    self.beTableViewing()
  }
  
  func bindRemoveButton (indexPath: NSIndexPath) {
    let cell = self.tableViewComponent.cellForRowAtIndexPath(indexPath) as SettingTableViewCell
    UIView.animateWithDuration(0.3, animations: {
      cell.deleteIcon.alpha = 1.0
    })
    cell.deleteIcon.addGestureRecognizer(self.tapGestureForRemoveArchive)
  }
  
  func unbindRemoveButton (indexPath: NSIndexPath) {
    let cell = self.tableViewComponent.cellForRowAtIndexPath(indexPath) as SettingTableViewCell
    UIView.animateWithDuration(0.3, animations: {
      cell.deleteIcon.alpha = 0.0
    })
    cell.deleteIcon.removeGestureRecognizer(self.tapGestureForRemoveArchive)
  }
  
  func removeArchive (sender: UITapGestureRecognizer) {
    if let indexPath = self.selectingIndexPath {
      if indexPath.section == 0 {
        ArchiveConnection.sharedInstance().removeRepository(indexPath.row)
      }
      if indexPath.section == 1 {
        ArchiveConnection.sharedInstance().removeGithub(indexPath.row)
      }
      self.selectingIndexPath = nil
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.selectingIndexPath = indexPath.isEqual(self.selectingIndexPath) ? nil : indexPath
  }
  
  func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    self.selectingIndexPath = nil
  }
  
  func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.isEqual(self.selectingIndexPath) {
      self.selectingIndexPath = nil
    }
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 44
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(
      SettingTableHeaderView.identifier
      ) as SettingTableHeaderView
    
    headerView.sectionName = self.tableViewComponent.data.sectionData[section].name
    return headerView
  }
  
  func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(
      SettingTableFooterView.identifier
      ) as SettingTableFooterView
    
    footerView.addIcon.addGestureRecognizer(self.tableViewComponent.data.sectionData[section].tapGesture)
    return footerView
  }
  
  func tableView(tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
    let footerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(
      SettingTableFooterView.identifier
      ) as SettingTableFooterView
    
    footerView.addIcon.removeGestureRecognizer(self.tableViewComponent.data.sectionData[section].tapGesture)
  }
  
}
