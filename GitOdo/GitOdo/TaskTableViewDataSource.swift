//
//  IssuesTableViewDataSource.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class TaskTableViewDataSource: NSObject, UITableViewDataSource {
  
  var repositories: [RepositoryObject] = [RepositoryObject]() {
    didSet {
      self.repositories.sort{ $0.owerRepo < $1.owerRepo }
    }
  }
  var issues = [String: [IssueObject]]()
  var pullRequests = [String: [PullRequestObject]]()
  
  func getCellCount (section: Int) -> Int {
    let repository = self.getRepository(section)
    var issuesCount = 0
    var pullRequestsCount = 0
    
    if let count = self.issues[repository.owerRepo]?.count {
      issuesCount += count
    }
    if let count = self.pullRequests[repository.owerRepo]?.count {
      pullRequestsCount += count
    }
    return issuesCount + pullRequestsCount
  }
  
  func getRepository (section: Int) -> RepositoryObject {
    return self.repositories[section]
  }
  
  func getPullRequest (indexPath: NSIndexPath) -> PullRequestObject? {
    let repository = self.getRepository(indexPath.section)
    if indexPath.row < self.pullRequests[repository.owerRepo]?.count {
      if let pullRequest = self.pullRequests[repository.owerRepo]?[indexPath.row] {
        return pullRequest
      }
    }
    return nil
  }
  
  func getIssue (indexPath: NSIndexPath) -> IssueObject? {
    let repository = self.getRepository(indexPath.section)
    let pullRequestsCount = self.pullRequests[repository.owerRepo] != nil ? self.pullRequests[repository.owerRepo]!.count : 0
    let index = indexPath.row - pullRequestsCount
    if index < self.issues[repository.owerRepo]?.count {
      if let issue = self.issues[repository.owerRepo]?[index] {
        return issue
      }
    }
    return nil
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.repositories.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.getCellCount(section)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(
      TaskTableViewCell.identifier,
      forIndexPath: indexPath
      ) as! TaskTableViewCell
    
    let repository = self.getRepository(indexPath.section)
    let github = ArchiveConnection.sharedInstance().getGithub(repository: repository)!
    
    cell.isEmptyCell = false
    
    if let pullRequest = self.getPullRequest(indexPath) {
      cell.title = pullRequest.title
      cell.type = "pullRequest"
      cell.issueNumber = pullRequest.number
      if let range = pullRequest.body?.rangeOfString("@\(github.account)") {
        cell.isAtYou = true;
      } else {
        cell.isAtYou = false;
      }
    }
    else if let issue = self.getIssue(indexPath) {
      cell.title = issue.title
      cell.type = "issue"
      cell.issueNumber = issue.number
      if let range = issue.body?.rangeOfString("@\(github.account)") {
        cell.isAtYou = true;
      } else {
        cell.isAtYou = false;
      }
    }
    else {
      cell.isEmptyCell = true
    }
    
    return cell
  }

}
