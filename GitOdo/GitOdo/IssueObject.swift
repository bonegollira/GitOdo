//
//  IssueObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

class IssueObject: NSObject {
  
  let url: String
  let labels_url: String
  let comments_url: String
  let events_url: String
  let html_url: String
  let id: Int
  let number: Int
  let title: String
  let user: UserObject
  let labels: JSON
  let state: String
  let locked: Bool
  let assignee: String?
  let milestone: String?
  let comments: Int
  let created_at: String
  let updated_at: String
  let closed_at: String?
  let body: String?
  
  init (issue :JSON) {
    self.url = issue["url"].stringValue
    self.labels_url = issue["labels_url"].stringValue
    self.comments_url = issue["comments_url"].stringValue
    self.events_url = issue["events_url"].stringValue
    self.html_url = issue["html_url"].stringValue
    self.id = issue["id"].intValue
    self.number = issue["number"].intValue
    self.title = issue["title"].stringValue
    self.user = UserObject(user: JSON(issue["user"].dictionaryObject!))
    self.labels = issue["labels"]
    self.state = issue["state"].stringValue
    self.locked = issue["locked"].boolValue
    self.assignee = issue["assignee"].string
    self.milestone = issue["milestone"].string
    self.comments = issue["comments"].intValue
    self.created_at = issue["created_at"].stringValue
    self.updated_at = issue["updated_at"].stringValue
    self.closed_at = issue["closed_at"].string
    self.body = issue["body"].string
  }
   
}
/*
{
url: "https://api.github.com/repos/bonegollira/GitOdo.dev/issues/2",
labels_url: "https://api.github.com/repos/bonegollira/GitOdo.dev/issues/2/labels{/name}",
comments_url: "https://api.github.com/repos/bonegollira/GitOdo.dev/issues/2/comments",
events_url: "https://api.github.com/repos/bonegollira/GitOdo.dev/issues/2/events",
html_url: "https://github.com/bonegollira/GitOdo.dev/issues/2",
id: 58496142,
number: 2,
title: "アット付き",
user: {
login: "bonegollira",
id: 2216415,
avatar_url: "https://avatars.githubusercontent.com/u/2216415?v=3",
gravatar_id: "",
url: "https://api.github.com/users/bonegollira",
html_url: "https://github.com/bonegollira",
followers_url: "https://api.github.com/users/bonegollira/followers",
following_url: "https://api.github.com/users/bonegollira/following{/other_user}",
gists_url: "https://api.github.com/users/bonegollira/gists{/gist_id}",
starred_url: "https://api.github.com/users/bonegollira/starred{/owner}{/repo}",
subscriptions_url: "https://api.github.com/users/bonegollira/subscriptions",
organizations_url: "https://api.github.com/users/bonegollira/orgs",
repos_url: "https://api.github.com/users/bonegollira/repos",
events_url: "https://api.github.com/users/bonegollira/events{/privacy}",
received_events_url: "https://api.github.com/users/bonegollira/received_events",
type: "User",
site_admin: false
},
labels: [ ],
state: "open",
locked: false,
assignee: null,
milestone: null,
comments: 0,
created_at: "2015-02-22T09:04:19Z",
updated_at: "2015-02-22T09:04:19Z",
closed_at: null,
body: "@boengollira 頑張れ"
},
*/