//
//  ArchiveConnection.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/09.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class ArchiveConnection: NSObject {
  
  class var sharedInstance: ArchiveConnection {
    struct Archive {
      static let instance = ArchiveConnection()
    }
    return Archive.instance
  }
  
  private let directory = NSHomeDirectory().stringByAppendingPathComponent("Documents")
  private var repositoryFilePath: String {
    get {
      return self.directory.stringByAppendingPathComponent("GitOdo.repositories")
    }
  }
  var repositories: [RepositoryObject] = []
  
  override init () {
    super.init()
    self.repositories = self.load()
  }
  
  func add (repository: RepositoryObject) {
    if !contains(self.repositories, repository) {
      self.repositories.append(repository)
    }
    self.save()
  }
  
  func remove (repository: RepositoryObject) {
    self.repositories = self.repositories.filter({$0 != repository})
    self.save()
  }
  
  func load () -> [RepositoryObject] {
    let archivedOrNil:AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithFile(self.repositoryFilePath)
    if let archived = archivedOrNil as? [RepositoryObject] {
      return archived
    }
    return []
  }
  
  func save () {
    NSKeyedArchiver.archiveRootObject(self.repositories, toFile: self.repositoryFilePath)
  }
  
}
