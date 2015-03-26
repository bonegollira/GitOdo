//
//  PullRequestObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/16.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

class PullRequestObject: NSObject {
  
  let type = "pullRequest"
  let url: String
  let id: Int
  let html_url: String
  let diff_url: String
  let patch_url: String
  let pullRequest_url: String
  let number: Int
  let state: String
  let locked: Bool
  let title: String
  let body: String?
  let created_at: String
  let updated_at: String
  let closed_at: String?
  let merged_at: String?
  let merge_commit_sha: String
  let assignee: String?
  let milestone: String?
  let comments_url: String
  let user: UserObject
  
  init (pullRequest :JSON) {
    self.url = pullRequest["url"].stringValue
    self.comments_url = pullRequest["comments_url"].stringValue
    self.html_url = pullRequest["html_url"].stringValue
    self.id = pullRequest["id"].intValue
    self.number = pullRequest["number"].intValue
    self.title = pullRequest["title"].stringValue
    self.user = UserObject(user: JSON(pullRequest["user"].dictionaryObject!))
    self.state = pullRequest["state"].stringValue
    self.locked = pullRequest["locked"].boolValue
    self.assignee = pullRequest["assignee"].string
    self.milestone = pullRequest["milestone"].string
    self.created_at = pullRequest["created_at"].stringValue
    self.updated_at = pullRequest["updated_at"].stringValue
    self.closed_at = pullRequest["closed_at"].string
    self.body = pullRequest["body"].string
    self.diff_url = pullRequest["diff_url"].stringValue
    self.patch_url = pullRequest["patch_url"].stringValue
    self.pullRequest_url = pullRequest["pullRequest_url"].stringValue
    self.merge_commit_sha = pullRequest["merge_commit_sha"].stringValue
    super.init()
  }
}