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
  
  func configure__searchBar () {
    self.searchBar.enablesReturnKeyAutomatically = false
    self.searchBar.placeholder = "search"
    self.searchBar.keyboardType = UIKeyboardType.Default
    self.searchBar.searchBarStyle = .Minimal
  }
  
  func autolayout__tableView () {
    layout(self.tableViewComponent) { issuesTableView in
      issuesTableView.edges == issuesTableView.superview!.edges
      return
    }
  }
  
  func render () {
    self.navigationItem.rightBarButtonItem = self.settingButtonItem
    self.navigationItem.titleView = self.searchBar
    self.tableViewComponent.render(self.view)
    self.configure__self()
    self.configure__settingButtonItem()
    self.configure__searchBar()
    self.autolayout__tableView()
  }
  
}

class ViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate, TaskTableViewHeaderViewDelegate {
  
  let settingButtonItem = UIBarButtonItem()
  let tableViewComponent = TaskTableViewComponent()
  let searchBar = UISearchBar()
  var shouldBeginSearching: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.settingButtonItem.target = self
    self.settingButtonItem.action = "pushSettingViewController:"
    self.tableViewComponent.delegate = self
    self.tableViewComponent.refreshControl.addTarget(self, action: "fetchData", forControlEvents: .ValueChanged)
    self.searchBar.delegate = self
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
      })
    }
  }
  
  func fetchRepositoryByOwerRepo (owerRepo: String) {
    let repository = ArchiveConnection.sharedInstance().repositories.filter({ $0.owerRepo.isEqual(owerRepo) })[0]
    GithubConnection.requestIssues(repository, callback: { (issues) in
      self.tableViewComponent.addRepository(repository, issues: issues)
    })
    GithubConnection.requestPullRequests(repository, callback: { (pullRequests) in
      self.tableViewComponent.addRepository(repository, pullRequests: pullRequests)
    })
  }
  
  func fetchPullRequestsData () {
    for repository in ArchiveConnection.sharedInstance().repositories {
      GithubConnection.requestPullRequests(repository, callback: { (pullRequests) in
        self.tableViewComponent.addRepository(repository, pullRequests: pullRequests)
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
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 25
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(
      TaskTableViewHeaderView.identifier
      ) as! TaskTableViewHeaderView
    let sectionName = self.tableViewComponent.data.sectionName(section)
    let rowCount = self.tableViewComponent.data.cellCount(section)
    headerView.delegate = self
    headerView.repositoryName = sectionName
    headerView.rowCount = rowCount
    headerView.section = section
    return headerView
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    var title: String = ""
    var issueNumber: Int = 0
    let todo = self.tableViewComponent.data.dataSource(indexPath)
    title = todo.title
    issueNumber = todo.number
    return TaskTableViewCell.height(self.tableViewComponent, title: title, issueNumber: issueNumber)
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let repository = self.tableViewComponent.data.repositories[indexPath.section]
    let todo = self.tableViewComponent.data.dataSource(indexPath)
    self.pushWKWebViewController(todo.html_url)
  }
  
  // MARK: TaskTableViewHeaderViewDelegate
  
  func taskTableViewHeaderView(headerView: TaskTableViewHeaderView, didSelectSection section: Int) {
    self.fetchRepositoryByOwerRepo(headerView.repositoryName)
  }
  
  // MARK: UISearchBarDelegate
  
  func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
    let shouldBeginSearching = self.shouldBeginSearching
    self.shouldBeginSearching = true
    return shouldBeginSearching
  }
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    self.tableViewComponent.filterBySearchWord(searchText)
    // for clear button
    if !searchBar.isFirstResponder() {
      self.shouldBeginSearching = false
    }
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}

