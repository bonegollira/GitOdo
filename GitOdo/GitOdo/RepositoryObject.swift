//
//  RepositoryObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/22.
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import Foundation

class RepositoryObject: NSObject, NSCoding {
  
  let host: String
  let ower :String
  let repo :String

  var owerRepo: String {
    return "\(self.ower)/\(self.repo)"
  }
  
  init (host: String = "github.com", ower: String, repo: String) {
    self.host = host
    self.ower = ower
    self.repo = repo
  }
  
  required init(coder aDecoder: NSCoder) {
    self.host = aDecoder.decodeObjectForKey("host") as String
    self.ower = aDecoder.decodeObjectForKey("ower") as String
    self.repo = aDecoder.decodeObjectForKey("repo") as String
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.host, forKey: "host")
    aCoder.encodeObject(self.ower, forKey: "ower")
    aCoder.encodeObject(self.repo, forKey: "repo")
  }
}
