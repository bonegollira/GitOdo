//
//  IssuesTableViewDataSource.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import Dollar

class TaskTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, TaskTableViewHeaderViewDelegate {
  
  private struct Source {
    var repository: RepositoryObject
    var todos: [protocol<ToDoObjectProtocol>]
  }

  weak var delegate: TaskTableViewDelegate?
  
  private var allSource: [Source] = [] {
    didSet {
      self.recreateSource()
    }
  }
  
  private var source: [Source] = [] {
    didSet {
      source = source
        .map{(aSource: Source) -> Source in
          var newSource = aSource
          let pullRequestNumbers = newSource.todos.filter{ $0.type == ToDoType.PullRequest }.map{ $0.number }
          newSource.todos = aSource.todos
            .filter{
              ($0.type == ToDoType.PullRequest) || !contains(pullRequestNumbers, $0.number)
            }
            // 10 ... 1
            .sorted{ $0.number > $1.number }
            .sorted{ $0.type.rawValue < $1.type.rawValue }
          return newSource
        }
        .filter{ $0.todos.count > 0 }
        .sorted{ $0.repository.owerRepo < $1.repository.owerRepo }
    }
  }
  
  var searchWord: String = "" {
    didSet {
      self.recreateSource()
    }
  }
  
  func recreateSource () {
    if self.searchWord.isEmpty {
      self.source = self.allSource
    }
    else {
      self.source = self.allSource.map{(source: Source) -> Source in
        let todos = source.todos.filter{[unowned self] (todo: protocol<ToDoObjectProtocol>) -> Bool in
          return todo.title.rangeOfString("\(self.searchWord)") != nil ? true : false
        }
        return Source(repository: source.repository, todos: todos)
      }
    }
  }
  
  func addSource (repository: RepositoryObject, type: ToDoType, todos: [protocol<ToDoObjectProtocol>]) {
    if let index = self.getIndexOfRepository(repository) {
      let diffTypeTodos = self.allSource[index].todos.filter{ $0.type != type }
      self.allSource[index].todos = diffTypeTodos + todos
    }
    else {
      self.allSource.append(Source(repository: repository, todos: todos))
    }
  }
  
  private func getIndexOfRepository (repository: RepositoryObject) -> Int? {
    return $.findIndex(self.allSource, callback: { (source: Source) -> Bool in
      return source.repository.owerRepo.isEqual(repository.owerRepo)
    })
  }
  
  func getRepository (section: Int) -> RepositoryObject {
    return self.source[section].repository
  }
  
  func getTodo (indexPath: NSIndexPath) -> protocol<ToDoObjectProtocol> {
    return self.source[indexPath.section].todos[indexPath.row]
  }
  
  // MARK: UITableViewDataSource
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.source.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.source[section].todos.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let repository = self.getRepository(indexPath.section)
    let todo = self.getTodo(indexPath)
    let github = ArchiveConnection.sharedInstance().getGithub(repository: repository)!
    let cell = tableView.dequeueReusableCellWithIdentifier(
      TaskTableViewCell.identifier,
      forIndexPath: indexPath
      ) as! TaskTableViewCell
    
    cell.title = todo.title
    cell.type = todo.type
    cell.issueNumber = todo.number
    cell.isAtYou = todo.body?.rangeOfString("@\(github.account)")?.isEmpty ?? false
    cell.comments = todo.comments
    return cell
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44
  }
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(
      TaskTableViewHeaderView.identifier
      ) as! TaskTableViewHeaderView
    headerView.delegate = self
    headerView.repository = self.getRepository(section)
    headerView.rowCount = self.source[section].todos.count
    headerView.section = section
    return headerView
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let todo = self.source[indexPath.section].todos[indexPath.row]
    return TaskTableViewCell.height(tableView, title: todo.title, issueNumber: todo.number)
  }
  
  // @bridge
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    self.delegate?.tableView?(tableView, didSelectRowAtIndexPath: indexPath)
  }
  
  // MARK: TaskTableViewHeaderViewDelegate
  
  // @bridge
  func taskTableViewHeaderView(headerView: TaskTableViewHeaderView, didSelectSection section: Int) {
    self.delegate?.taskTableViewHeaderView?(headerView, didSelectSection: section)
  }

}
