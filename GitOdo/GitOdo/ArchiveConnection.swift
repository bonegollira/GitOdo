//
//  ArchiveConnection.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/09.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

@objc protocol ArchiveConnectionDelegate: NSObjectProtocol {
  optional func didAddedRepository (repository: RepositoryObject, index: Int)
  optional func didAddedGithub (github: GithubObject, index: Int)
  optional func didRemovedRepository (repository: RepositoryObject, index: Int)
  optional func didRemovedGithub (github: GithubObject, index: Int)
}

class ArchiveConnection: NSObject {
  
  private struct ArchiveConnectionInstance {
    static let instance = ArchiveConnection()
  }
  
  class func sharedInstance () -> ArchiveConnection {
    return ArchiveConnectionInstance.instance
  }
  
  private struct Directory {
    static let root = NSHomeDirectory().stringByAppendingPathComponent("Documents")
    static let repository = root.stringByAppendingPathComponent("GitOdo.repositories")
    static let github = root.stringByAppendingPathComponent("GitOdo.githubs")
  }

  var repositories: [RepositoryObject] = [RepositoryObject]() {
    didSet {
      NSKeyedArchiver.archiveRootObject(self.repositories, toFile: Directory.repository)
    }
  }
  var githubs: [GithubObject] = [GithubObject]() {
    didSet {
      NSKeyedArchiver.archiveRootObject(self.githubs, toFile: Directory.github)
    }
  }
  
  weak var delegate: ArchiveConnectionDelegate?
  
  override init () {
    super.init()
    self.repositories = self.unarchiveRepositories()
    self.githubs = self.unarchiveGithubs()
  }
  
  func getGithub (repository: RepositoryObject) -> GithubObject? {
    return self.getGithub(repository.host)
  }
  
  func getGithub (host: String) -> GithubObject? {
    let someGithub = self.githubs.filter({ host == $0.host })
    return someGithub.count > 0 ? someGithub.first : nil
  }
  
  func addRepository (repository: RepositoryObject) {
    if !contains(self.repositories, repository) {
      self.repositories.append(repository)
      self.delegate?.didAddedRepository?(repository, index: self.repositories.count)
    }
  }
  
  func addRepository (ower: String, repo: String, enterprise: String = "") {
    if !ower.canBeConvertedToEncoding(NSASCIIStringEncoding) {
      return
    }
    if !repo.canBeConvertedToEncoding(NSASCIIStringEncoding) {
      return
    }
    if !enterprise.canBeConvertedToEncoding(NSASCIIStringEncoding) {
      return
    }
    
    let github = self.githubs
    
    let repository = enterprise.isEmpty ? RepositoryObject(
      ower: ower,
      repo: repo
      ) : RepositoryObject(
        host: enterprise,
        ower: ower,
        repo: repo
    )
    self.addRepository(repository)
  }
  
  func addGithub (github: GithubObject) {
    if self.githubs.filter({ $0.host == github.host }).count == 0 {
      self.githubs.append(github)
      self.delegate?.didAddedGithub?(github, index: self.githubs.count)
    }
  }
  
  func addGithub (account: String, accessToken: String, host: String = "") {
    if !accessToken.canBeConvertedToEncoding(NSASCIIStringEncoding) {
      return
    }
    if !host.canBeConvertedToEncoding(NSASCIIStringEncoding) {
      return
    }
    
    let github = GithubObject(account: account, accessToken: accessToken)
    if !host.isEmpty {
      github.host = host
    }
    self.addGithub(github)
  }
  
  func removeRepository (repository: RepositoryObject, index: Int) {
    self.repositories.removeAtIndex(index)
    self.delegate?.didRemovedRepository?(repository, index: index)
  }
  
  func removeRepository (repository: RepositoryObject) {
    if let index = find(self.repositories, repository) {
      self.removeRepository(repository, index: index)
    }
  }
  
  func removeRepository (index: Int) {
    self.removeRepository(self.repositories[index], index: index)
  }
  
  func removeGithub (github: GithubObject, index: Int) {
    self.githubs.removeAtIndex(index)
    self.delegate?.didRemovedGithub?(github, index: index)
  }
  
  func removeGithub (github: GithubObject) {
    if let index = find(self.githubs, github) {
      self.removeGithub(github, index: index)
    }
  }
  
  func removeGithub (index: Int) {
    self.removeGithub(self.githubs[index], index: index)
  }
  
  func unarchiveRepositories () -> [RepositoryObject] {
    let archivedOrNil: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithFile(Directory.repository)
    if let archived = archivedOrNil as? [RepositoryObject] {
      return archived
    }
    return []
  }
  
  func unarchiveGithubs () -> [GithubObject] {
    let archivedOrNil:AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithFile(Directory.github)
    if let archived = archivedOrNil as? [GithubObject] {
      return archived
    }
    return []
  }
}
