//
//  RepositoryObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/22.
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import Foundation

class RepositoryObject: NSObject, NSCoding {
  class var defaultApi: String {
    return "https://api.github.com"
  }
  let root :String
  let ower :String
  let repo :String
  var github: String {
    return "\(self.ower)/\(self.repo)"
  }
  var issuesApi: String {
    return "\(self.root)/repos/\(self.github)/issues"
  }
  var pullrequestApi: String {
    return "\(self.root)/repos/\(self.github)/pulls"
  }
  
  init (root: String = "https://api.github.com", ower: String, repo: String) {
    self.root = root
    self.ower = ower
    self.repo = repo
  }
  
  required init(coder aDecoder: NSCoder) {
    self.root = aDecoder.decodeObjectForKey("root") as String
    self.ower = aDecoder.decodeObjectForKey("ower") as String
    self.repo = aDecoder.decodeObjectForKey("repo") as String
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.root, forKey: "root")
    aCoder.encodeObject(self.ower, forKey: "ower")
    aCoder.encodeObject(self.repo, forKey: "repo")
  }
}
/*

// 保存するデータ
var users = [
SampleUser(id: 1, name: "Aichi"),
SampleUser(id: 2, name: "Gifu"),
SampleUser(id: 3, name: "Mie"),
]
// NSKeyedArchiverクラスを使ってデータを保存する。
let success = NSKeyedArchiver.archiveRootObject(users, toFile: _path)

if success {
println("保存に成功")
}

// NSKeyedUnarchiverクラスを使って保存したデータを読み込む。
let users = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as [SampleUser]

for user in users {
println("ID: \(user.id), NAME: \(user.name)")
}
*/
