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
  
  init (accessToken: String) {
    self.accessToken = accessToken
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    self.host = aDecoder.decodeObjectForKey("host") as String
    self.apiRoot = aDecoder.decodeObjectForKey("apiRoot") as String
    self.accessToken = aDecoder.decodeObjectForKey("accessToken") as String
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.host, forKey: "host")
    aCoder.encodeObject(self.apiRoot, forKey: "apiRoot")
    aCoder.encodeObject(self.accessToken, forKey: "accessToken")
  }
  
  func api (type: String, repo: String) -> String {
    return "\(self.apiRoot)/repos/\(repo)/\(type)"
  }
}
