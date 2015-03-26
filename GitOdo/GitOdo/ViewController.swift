//
//  ViewController.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/21.
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON
import Cartography

extension ViewController: ViewControllerLayout {
  
  func configure__self () {
    self.title = ""
  }
  
  func configure__settingButtonItem () {
    self.settingButtonItem.title = "\u{f031}"
    self.settingButtonItem.setTitleTextAttributes(
      [NSFontAttributeName: UIFont(name: "octicons", size: 22)!],
      forState: UIControlState.Normal
    )
  }
  
  func autolayout__tableView () {
    layout(self.tableViewComponent) { issuesTableView in
      issuesTableView.edges == issuesTableView.superview!.edges
      return
    }
  }
  
  func render () {
    self.navigationItem.rightBarButtonItem = self.settingButtonItem
    self.tableViewComponent.render(self.view)
    self.configure__self()
    self.configure__settingButtonItem()
    self.autolayout__tableView()
  }
  
}

class ViewController: UIViewController, UITableViewDelegate {
  
  let settingButtonItem = UIBarButtonItem()
  let tableViewComponent = TaskTableViewComponent()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.settingButtonItem.target = self
    self.settingButtonItem.action = "pushSettingViewController:"
    self.tableViewComponent.delegate = self
    self.tableViewComponent.refreshControl.addTarget(self, action: "fetchData", forControlEvents: .ValueChanged)
    self.render()
    self.fetchData()
  }
  
  func fetchData () {
    self.tableViewComponent.refreshControl.endRefreshing()
    self.fetchIssuesData()
    self.fetchPullRequestsData()
  }
  
  func fetchIssuesData () {
    for repository in ArchiveConnection.sharedInstance().repositories {
      GithubConnection.requestIssues(repository, callback: { (issues) in
        self.tableViewComponent.addRepository(repository, issues: issues)
        self.tableViewComponent.reloadData()
      })
    }
  }
  
  func fetchPullRequestsData () {
    for repository in ArchiveConnection.sharedInstance().repositories {
      GithubConnection.requestPullRequests(repository, callback: { (pullRequests) in
        self.tableViewComponent.addRepository(repository, pullRequests: pullRequests)
        self.tableViewComponent.reloadData()
      })
    }
  }
  
  func pushSettingViewController (sender: UIBarButtonItem) {
    self.navigationController?.pushViewController(
      SettingViewController(),
      animated: true
    )
  }
  
  func pushWKWebViewController (url: String) {
    let webViewController = WKWebViewController()
    self.navigationController?.pushViewController(
      webViewController,
      animated: true
    )
    webViewController.loadURLString(url)
  }
  
  func didSelectedIssue (issue: IssueObject) {
    self.pushWKWebViewController(issue.html_url)
  }
  
  func didSelectedPullRequest(pullRequest: PullRequestObject) {
    self.pushWKWebViewController(pullRequest.html_url)
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 25
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(
      TaskTableViewHeaderView.identifier
      ) as TaskTableViewHeaderView
    let repositoryName = self.tableViewComponent.data.repositories[section]
    let rowCount = self.tableViewComponent.data.getCellCount(section)
    headerView.repositoryName = repositoryName
    headerView.rowCount = rowCount
    return headerView
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let repository = self.tableViewComponent.data.getRepository(indexPath.section)
    
    if let pullRequest = self.tableViewComponent.data.getPullRequest(indexPath) {
      self.pushWKWebViewController(pullRequest.html_url)
    }
    else if let issue = self.tableViewComponent.data.getIssue(indexPath) {
      self.pushWKWebViewController(issue.html_url)
    }
  }
}

