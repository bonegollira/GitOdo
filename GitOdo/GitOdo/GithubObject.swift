//
//  Github.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/15.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

class GithubObject: NSObject {
  
  var host: String = "github.com" {
    didSet {
      self.apiRoot = host == "github.com" ? "https://api.github.com" : "https://\(host)/api/v3"
    }
  }
  var apiRoot: String = "https://api.github.com"
  var accessToken: String
  var account: String
  
  init (account: String, accessToken: String) {
    self.accessToken = accessToken
    self.account = account
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    self.host = aDecoder.decodeObjectForKey("host") as String
    self.apiRoot = aDecoder.decodeObjectForKey("apiRoot") as String
    self.accessToken = aDecoder.decodeObjectForKey("accessToken") as String
    self.account = aDecoder.decodeObjectForKey("account") as String
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.host, forKey: "host")
    aCoder.encodeObject(self.apiRoot, forKey: "apiRoot")
    aCoder.encodeObject(self.accessToken, forKey: "accessToken")
    aCoder.encodeObject(self.account, forKey: "account")
  }
  
  func api (type: String, repo: String) -> String {
    return "\(self.apiRoot)/repos/\(repo)/\(type)"
  }
}
