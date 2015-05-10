//
//  UserObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserObject: NSObject {
  
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
   
}
