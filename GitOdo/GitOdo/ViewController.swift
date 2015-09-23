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
import Dollar

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
    constrain(self.tableViewComponent) { issuesTableView in
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

class ViewController: UIViewController, UISearchBarDelegate, TaskTableViewDelegate {
  
  let settingButtonItem = UIBarButtonItem()
  let tableViewComponent = TaskTableViewComponent()
  let searchBar = UISearchBar()
  var shouldBeginSearching: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.settingButtonItem.target = self
    self.settingButtonItem.action = "pushSettingViewController:"
    self.tableViewComponent.delegate = self
    self.tableViewComponent.refreshControl.addTarget(self, action: "fetchAllData", forControlEvents: .ValueChanged)
    self.searchBar.delegate = self
    self.render()
    self.restoreAllData()
    self.fetchAllData()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    ArchiveConnection.sharedInstance().delegate = self.tableViewComponent
  }
  
  func restoreAllData () {
    for (repository, todos) in ArchiveConnection.sharedInstance().todos {
      self.tableViewComponent.dataSource.registSource(repository, todos: todos)
    }
  }
  
  func fetchAllData () {
    if self.tableViewComponent.refreshControl.refreshing {
      self.tableViewComponent.refreshControl.endRefreshing()
    }
    
    for repository in ArchiveConnection.sharedInstance().repositories {
      self.fetchRepositoryByOwerRepo(repository)
    }
  }
  
  func fetchRepositoryByOwerRepo (repository: RepositoryObject) {
    GithubConnection.requestIssues(repository, callback: self.fetchData(repository, type: .Issue))
    GithubConnection.requestPullRequests(repository, callback: self.fetchData(repository, type: .PullRequest))
  }
  
  private func fetchData <T: ToDoObjectProtocol> (repository: RepositoryObject, type: ToDoType) -> ([T]) -> Void {
    return {(todos: [T]) in
      ArchiveConnection.sharedInstance().addTodos(repository, type: type, todos: todos)
    }
  }
  
  func pushSettingViewController (sender: UIBarButtonItem) {
    self.navigationController?.pushViewController(SettingViewController(), animated: true)
  }
  
  func pushWKWebViewController (url: String) {
    let webViewController = WKWebViewController()
    self.navigationController?.pushViewController(webViewController, animated: true)
    webViewController.loadURLString(url)
  }
  
  func didSelectedIssue (issue: IssueObject) {
    self.pushWKWebViewController(issue.html_url)
  }
  
  func didSelectedPullRequest(pullRequest: PullRequestObject) {
    self.pushWKWebViewController(pullRequest.html_url)
  }
  
  // MARK: TaskTableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let todo = self.tableViewComponent.dataSource.getTodo(indexPath)
    self.pushWKWebViewController(todo.html_url)
  }

  // MARK: TaskTableViewHeaderViewDelegate
  
  func taskTableViewHeaderView(headerView: TaskTableViewHeaderView, didSelectSection section: Int) {
    self.fetchRepositoryByOwerRepo(headerView.repository!)
  }
  
  func taskTableViewHeaderView(headerView: TaskTableViewHeaderView, didSelectAdd section: Int) {
    self.pushWKWebViewController(headerView.repository!.newIssueUrlString)
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

