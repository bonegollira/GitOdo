//
//  UserObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserObject: NSObject, NSCoding {
  
  let login: String
  let avatar_url: String
  let gravatar_id: String
  let url: String
  let html_url: String
  let followers_url: String
  let following_url: String
  let gists_url: String
  let starred_url: String
  let subscriptions_url: String
  let organizations_url: String
  let repos_url: String
  let events_url: String
  let received_events_url: String
  let type: String
  let site_admin: Bool
  
  init (_ user: JSON) {
    self.login = user["login"].stringValue
    self.avatar_url = user["avatar_url"].stringValue
    self.gravatar_id = user["gravatar_id"].stringValue
    self.url = user["url"].stringValue
    self.html_url = user["html_url"].stringValue
    self.followers_url = user["followers_url"].stringValue
    self.following_url = user["following_url"].stringValue
    self.gists_url = user["gists_url"].stringValue
    self.starred_url = user["starred_url"].stringValue
    self.subscriptions_url = user["subscriptions_url"].stringValue
    self.organizations_url = user["organizations_url"].stringValue
    self.repos_url = user["repos_url"].stringValue
    self.events_url = user["events_url"].stringValue
    self.received_events_url = user["received_events_url"].stringValue
    self.type = user["type"].stringValue
    self.site_admin = user["site_admin"].boolValue
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    self.login = aDecoder.decodeObjectForKey("login") as! String
    self.avatar_url = aDecoder.decodeObjectForKey("avatar_url") as! String
    self.gravatar_id = aDecoder.decodeObjectForKey("gravatar_id") as! String
    self.url = aDecoder.decodeObjectForKey("url") as! String
    self.html_url = aDecoder.decodeObjectForKey("html_url") as! String
    self.followers_url = aDecoder.decodeObjectForKey("followers_url") as! String
    self.following_url = aDecoder.decodeObjectForKey("following_url") as! String
    self.gists_url = aDecoder.decodeObjectForKey("gists_url") as! String
    self.starred_url = aDecoder.decodeObjectForKey("starred_url") as! String
    self.subscriptions_url = aDecoder.decodeObjectForKey("subscriptions_url") as! String
    self.organizations_url = aDecoder.decodeObjectForKey("organizations_url") as! String
    self.repos_url = aDecoder.decodeObjectForKey("repos_url") as! String
    self.events_url = aDecoder.decodeObjectForKey("events_url") as! String
    self.received_events_url = aDecoder.decodeObjectForKey("received_events_url") as! String
    self.type = aDecoder.decodeObjectForKey("type") as! String
    self.site_admin = aDecoder.decodeObjectForKey("site_admin") as! Bool
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.login, forKey: "login")
    aCoder.encodeObject(self.avatar_url, forKey: "avatar_url")
    aCoder.encodeObject(self.gravatar_id, forKey: "gravatar_id")
    aCoder.encodeObject(self.url, forKey: "url")
    aCoder.encodeObject(self.html_url, forKey: "html_url")
    aCoder.encodeObject(self.followers_url, forKey: "followers_url")
    aCoder.encodeObject(self.following_url, forKey: "following_url")
    aCoder.encodeObject(self.gists_url, forKey: "gists_url")
    aCoder.encodeObject(self.starred_url, forKey: "starred_url")
    aCoder.encodeObject(self.subscriptions_url, forKey: "subscriptions_url")
    aCoder.encodeObject(self.organizations_url, forKey: "organizations_url")
    aCoder.encodeObject(self.repos_url, forKey: "repos_url")
    aCoder.encodeObject(self.events_url, forKey: "events_url")
    aCoder.encodeObject(self.received_events_url, forKey: "received_events_url")
    aCoder.encodeObject(self.type, forKey: "type")
    aCoder.encodeObject(self.site_admin, forKey: "site_admin")
  }
   
}
