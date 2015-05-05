//
//  IssuesTableViewDataSource.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Dollar

class TaskTableViewDataSource: NSObject, UITableViewDataSource {
  
  var searchWord: String = "" {
    didSet {
      self.recreateDataSource()
    }
  }
  var repositories: [RepositoryObject] = [RepositoryObject]()
  var issues = [String: [IssueObject]]() {
    didSet {
      self.recreateDataSource()
    }
  }
  var pullRequests = [String: [PullRequestObject]]() {
    didSet {
      self.recreateDataSource()
    }
  }
  
  // filter data by search word.
  
  private var __repositories: [RepositoryObject] = [RepositoryObject]() {
    didSet {
      self.__repositories.sort{ $0.owerRepo < $1.owerRepo }
    }
  }
  
  private var __dataSource: [String: [ToDoObject]] = [:] {
    didSet {
      let owerRepos = $.keys(__dataSource)
      self.__repositories = $.map(owerRepos, transform: {(owerRepo: String) -> RepositoryObject in
        return $.find(self.repositories, callback: { $0.owerRepo.isEqual(owerRepo) })!
      })
    }
  }
  
  private func recreateDataSource () {
    var fullDataSource: [String: [ToDoObject]] = [:]
    var dataSource: [String: [ToDoObject]] = [:]
    
    $.each(self.repositories, callback: { (repository: RepositoryObject) in
      let owerRepo = repository.owerRepo
      if let issue = self.issues[owerRepo], let pullRequest = self.pullRequests[owerRepo] {
        fullDataSource[owerRepo] = $.merge(pullRequest, issue)
      }
    })
    
    for (owerRepo, todos) in fullDataSource {
      let filteredTodos = todos.filter({ (todo: ToDoObject) -> Bool in
        if self.searchWord.isEmpty {
          return true
        }
        return todo.title.rangeOfString("\(self.searchWord)") != nil ? true : false
      })
      if filteredTodos.count > 0 {
        dataSource[owerRepo] = filteredTodos
      }
    }
    self.__dataSource = dataSource
  }
  
  // MARK: getter for data sources.
  
  func cellCount (section: Int) -> Int {
    let owerRepo = self.__repositories[section].owerRepo
    return self.__dataSource[owerRepo]?.count ?? 0
  }
  
  func dataSource (indexPath: NSIndexPath) -> ToDoObject {
    let owerRepo = self.__repositories[indexPath.section].owerRepo
    let todos = self.__dataSource[owerRepo]!
    return todos[indexPath.row]
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
    let todo = self.dataSource(indexPath)
    let cell = tableView.dequeueReusableCellWithIdentifier(
      TaskTableViewCell.identifier,
      forIndexPath: indexPath
      ) as! TaskTableViewCell
    
    cell.title = todo.title
    cell.type = todo.type
    cell.issueNumber = todo.number
    cell.isAtYou = todo.body?.rangeOfString("@\(github.account)")?.isEmpty ?? false
    
    return cell
  }
  
  // MARK: UITableViewDataSource(Custom)
  
  func sectionName (section: Int) -> String {
    return self.__repositories[section].owerRepo
  }

}
