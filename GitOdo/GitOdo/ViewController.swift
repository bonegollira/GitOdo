//
//  ViewController.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/21.
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cartography

// RefectorはSwiftでは使えない
class ViewController: UIViewController {
  
  let refreshButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: nil, action: "")
  let repositoryButtonItem = UIBarButtonItem(barButtonSystemItem: .Organize, target: nil, action: "")
  let issuesTableViewComponent = IssuesTableViewComponent()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configure()
    self.configure_refreshButtonItem()
    self.configure_repositoryButtonItem()
    self.configure_issuesTableViewComponent()
    self.navigationItem.leftBarButtonItem = self.refreshButtonItem
    self.navigationItem.rightBarButtonItem = self.repositoryButtonItem
    self.view.addSubview(self.issuesTableViewComponent.view)
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.loadIssues()
  }
  
  override func viewDidLayoutSubviews() {
    layout(self.issuesTableViewComponent.view) { issuesTableView in
      issuesTableView.edges == issuesTableView.superview!.edges
      return
    }
  }
  
  func configure () {
    self.title = "GitOdo"
  }
  
  func configure_refreshButtonItem () {
    self.refreshButtonItem.target = self
    self.refreshButtonItem.action = "loadIssues"
  }
  
  func configure_repositoryButtonItem () {
    self.repositoryButtonItem.target = self
    self.repositoryButtonItem.action = "pushRepositoryViewController:"
  }
  
  func configure_issuesTableViewComponent () {
  }
  
  func loadIssues () {
    for repository in ArchiveConnection.sharedInstance.repositories {
      GithubConnection.requestIssues(repository, callback: { (issues) in
        self.issuesTableViewComponent.addRepository(repository, issues: issues)
        self.issuesTableViewComponent.cleaning()
        self.issuesTableViewComponent.view.reloadData()
      })
    }
  }
  
  func removeIssues () {
  }
  
  func pushRepositoryViewController (sender: UIBarButtonItem) {
    self.navigationController?.pushViewController(
      RepositoryViewController(),
      animated: true
    )
  }
  
  func issuesMock () -> [IssueObject] {
    var sampleJSON = [
      "url": "https://api.github.com/repos/bonegollira/GitOdo.dev/issues/2",
      "labels_url": "https://api.github.com/repos/bonegollira/GitOdo.dev/issues/2/labels{/name}",
      "comments_url": "https://api.github.com/repos/bonegollira/GitOdo.dev/issues/2/comments",
      "events_url": "https://api.github.com/repos/bonegollira/GitOdo.dev/issues/2/events",
      "html_url": "https://github.com/bonegollira/GitOdo.dev/issues/2",
      "id": 58496142,
      "number": 2,
      "title": "アット付きaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      "user": [
        "login": "bonegollira",
        "id": 2216415,
        "avatar_url": "https://avatars.githubusercontent.com/u/2216415?v=3",
        "gravatar_id": "",
        "url": "https://api.github.com/users/bonegollira",
        "html_url": "https://github.com/bonegollira",
        "followers_url": "https://api.github.com/users/bonegollira/followers",
        "following_url": "https://api.github.com/users/bonegollira/following{/other_user}",
        "gists_url": "https://api.github.com/users/bonegollira/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/bonegollira/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/bonegollira/subscriptions",
        "organizations_url": "https://api.github.com/users/bonegollira/orgs",
        "repos_url": "https://api.github.com/users/bonegollira/repos",
        "events_url": "https://api.github.com/users/bonegollira/events{/privacy}",
        "received_events_url": "https://api.github.com/users/bonegollira/received_events",
        "type": "User",
        "site_admin": false
      ],
      "labels": [],
      "state": "open",
      "locked": false,
      "assignee": NSNull(),
      "milestone": NSNull(),
      "comments": 0,
      "created_at": "2015-02-22T09:04:19Z",
      "updated_at": "2015-02-22T09:04:19Z",
      "closed_at": NSNull(),
      "body": "@boengollira 頑張れ"
    ]
    
    return [
      IssueObject(issue: JSON(sampleJSON)),
      IssueObject(issue: JSON(sampleJSON)),
      IssueObject(issue: JSON(sampleJSON)),
      IssueObject(issue: JSON(sampleJSON)),
      IssueObject(issue: JSON(sampleJSON)),
      IssueObject(issue: JSON(sampleJSON)),
      IssueObject(issue: JSON(sampleJSON)),
      IssueObject(issue: JSON(sampleJSON)),
      IssueObject(issue: JSON(sampleJSON))
    ]
  }
}

