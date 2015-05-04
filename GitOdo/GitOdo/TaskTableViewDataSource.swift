//
//  IssuesTableViewDataSource.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class TaskTableViewDataSource: NSObject, UITableViewDataSource {
  
  var searchWord: String = "" {
    didSet {
      self.filter()
    }
  }
  var repositories: [RepositoryObject] = [RepositoryObject]() {
    didSet {
      self.repositories.sort{ $0.owerRepo < $1.owerRepo }
    }
  }
  var issues = [String: [IssueObject]]() {
    didSet {
      self.filter()
    }
  }
  var pullRequests = [String: [PullRequestObject]]() {
    didSet {
      self.filter()
    }
  }
  
  // filter data by search word.
  
  private var __repositories: [RepositoryObject] = [RepositoryObject]() {
    didSet {
      self.__repositories.sort{ $0.owerRepo < $1.owerRepo }
    }
  }
  private var __issues: [String: [IssueObject]] = [String: [IssueObject]]()
  private var __pullRequests: [String: [PullRequestObject]] = [String: [PullRequestObject]]()
  
  private func filter () {
    if (self.searchWord.isEmpty) {
      self.__repositories = self.repositories
      self.__issues = self.issues
      self.__pullRequests = self.pullRequests
      return
    }
    
    var __pullRequests = [String: [PullRequestObject]]()
    var __issues = [String: [IssueObject]]()
    self.__repositories.removeAll()
    
    for (owerRepo, issues) in self.issues {
      let filteredIssues = issues.filter({ (issue: IssueObject) -> Bool in
        if let range = issue.title.rangeOfString("\(self.searchWord)") {
          return true
        }
        return false
      })
      
      if filteredIssues.count > 0 {
        __issues[owerRepo] = filteredIssues
        if !contains(self.__repositories, { $0.owerRepo.isEqual(owerRepo) }) {
          let repository = self.repositories.filter({ $0.owerRepo.isEqual(owerRepo) })[0]
          self.__repositories.append(repository)
        }
      }
      
      for (owerRepo, pullRequests) in self.pullRequests {
        let filteredPullRequests = pullRequests.filter({ (pullRequest: PullRequestObject) -> Bool in
          if let range = pullRequest.title.rangeOfString("\(self.searchWord)") {
            return true
          }
          return false
        })
        
        if filteredPullRequests.count > 0 {
          __pullRequests[owerRepo] = filteredPullRequests
          if !contains(self.__repositories, { $0.owerRepo.isEqual(owerRepo) }) {
            let repository = self.repositories.filter({ $0.owerRepo.isEqual(owerRepo) })[0]
            self.__repositories.append(repository)
          }
        }
      }
    }
    self.__pullRequests = __pullRequests
    self.__issues = __issues
  }
  
  // MARK: getter for data sources.
  
  func cellCount (section: Int) -> Int {
    let owerRepo = self.__repositories[section].owerRepo
    var count = 0
    count += self.__issues[owerRepo]?.count ?? 0
    count += self.__pullRequests[owerRepo]?.count ?? 0
    return count
  }
  
  func pullRequest (indexPath: NSIndexPath) -> PullRequestObject? {
    let owerRepo = self.__repositories[indexPath.section].owerRepo
    
    if indexPath.row >= self.__pullRequests[owerRepo]?.count {
      return nil
    }
    return self.__pullRequests[owerRepo]?[indexPath.row] ?? nil
  }
  
  func issue (indexPath: NSIndexPath) -> IssueObject? {
    let owerRepo = self.__repositories[indexPath.section].owerRepo
    let pullRequestsCount = self.__pullRequests[owerRepo]?.count ?? 0
    let index = indexPath.row - pullRequestsCount
    return self.__issues[owerRepo]?[index] ?? nil
  }
  
  // MARK: UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.__repositories.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cellCount(section)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let repository = self.__repositories[indexPath.section]
    let github = ArchiveConnection.sharedInstance().getGithub(repository: repository)!
    let cell = tableView.dequeueReusableCellWithIdentifier(
      TaskTableViewCell.identifier,
      forIndexPath: indexPath
      ) as! TaskTableViewCell
    
    if let pullRequest = self.pullRequest(indexPath) {
      cell.title = pullRequest.title
      cell.type = "pullRequest"
      cell.issueNumber = pullRequest.number
      cell.isAtYou = pullRequest.body?.rangeOfString("@\(github.account)")?.isEmpty ?? false
    }
    else if let issue = self.issue(indexPath) {
      cell.title = issue.title
      cell.type = "issue"
      cell.issueNumber = issue.number
      cell.isAtYou = issue.body?.rangeOfString("@\(github.account)")?.isEmpty ?? false
    }
    
    return cell
  }
  
  // MARK: UITableViewDataSource(Custom)
  
  func sectionName (section: Int) -> String {
    return self.__repositories[section].owerRepo
  }

}
