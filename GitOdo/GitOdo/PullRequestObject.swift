//
//  PullRequestObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/16.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

class PullRequestObject: NSObject, ToDoObjectProtocol {
  
  // MARK: ToDoObjectProtocol
  let type: ToDoType
  let html_url: String
  let number: Int
  let title: String
  let body: String?
  let comments: Int
  
  // MARK: IssueObject
  
  let url: String
  let id: Int
  let diff_url: String
  let patch_url: String
  let pullRequest_url: String
  let state: String
  let locked: Bool
  let created_at: String
  let updated_at: String
  let closed_at: String?
  let merged_at: String?
  let merge_commit_sha: String
  let assignee: String?
  let milestone: String?
  let comments_url: String
  let user: UserObject
  
  init (_ pullRequest :JSON) {
    self.type = .PullRequest
    self.html_url = pullRequest["html_url"].stringValue
    self.number = pullRequest["number"].intValue
    self.title = pullRequest["title"].stringValue
    self.body = pullRequest["body"].string
    self.comments = pullRequest["comments"].int ?? 0
    
    self.url = pullRequest["url"].stringValue
    self.comments_url = pullRequest["comments_url"].stringValue
    self.id = pullRequest["id"].intValue
    self.user = UserObject(JSON(pullRequest["user"].dictionaryObject!))
    self.state = pullRequest["state"].stringValue
    self.locked = pullRequest["locked"].boolValue
    self.assignee = pullRequest["assignee"].string
    self.milestone = pullRequest["milestone"].string
    self.created_at = pullRequest["created_at"].stringValue
    self.updated_at = pullRequest["updated_at"].stringValue
    self.closed_at = pullRequest["closed_at"].string
    self.diff_url = pullRequest["diff_url"].stringValue
    self.patch_url = pullRequest["patch_url"].stringValue
    self.pullRequest_url = pullRequest["pullRequest_url"].stringValue
    self.merge_commit_sha = pullRequest["merge_commit_sha"].stringValue
    self.merged_at = pullRequest["merged_at"].string
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.type = ToDoType.fromInt(aDecoder.decodeObjectForKey("type") as! Int)
    self.html_url = aDecoder.decodeObjectForKey("html_url") as! String
    self.number = aDecoder.decodeObjectForKey("number") as! Int
    self.title = aDecoder.decodeObjectForKey("title") as! String
    self.body = aDecoder.decodeObjectForKey("body") as? String
    self.comments = aDecoder.decodeObjectForKey("comments") as! Int
    
    self.url = aDecoder.decodeObjectForKey("url") as! String
    self.comments_url = aDecoder.decodeObjectForKey("comments_url") as! String
    self.id = aDecoder.decodeObjectForKey("id") as! Int
    self.user = aDecoder.decodeObjectForKey("user") as! UserObject
    self.state = aDecoder.decodeObjectForKey("state") as! String
    self.locked = aDecoder.decodeObjectForKey("locked") as! Bool
    self.assignee = aDecoder.decodeObjectForKey("assignee") as? String
    self.milestone = aDecoder.decodeObjectForKey("milestone") as? String
    self.created_at = aDecoder.decodeObjectForKey("created_at") as! String
    self.updated_at = aDecoder.decodeObjectForKey("updated_at") as! String
    self.closed_at = aDecoder.decodeObjectForKey("closed_at") as? String
    self.diff_url = aDecoder.decodeObjectForKey("diff_url") as! String
    self.patch_url = aDecoder.decodeObjectForKey("patch_url") as! String
    self.pullRequest_url = aDecoder.decodeObjectForKey("pullRequest_url") as! String
    self.merge_commit_sha = aDecoder.decodeObjectForKey("merge_commit_sha") as! String
    self.merged_at = aDecoder.decodeObjectForKey("merged_at") as? String
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.type.rawValue, forKey: "type")
    aCoder.encodeObject(self.html_url, forKey: "html_url")
    aCoder.encodeObject(self.number, forKey: "number")
    aCoder.encodeObject(self.title, forKey: "title")
    aCoder.encodeObject(self.body, forKey: "body")
    aCoder.encodeObject(self.comments, forKey: "comments")
    
    aCoder.encodeObject(self.url, forKey: "url")
    aCoder.encodeObject(self.comments_url, forKey: "comments_url")
    aCoder.encodeObject(self.id, forKey: "id")
    aCoder.encodeObject(self.user, forKey: "user")
    aCoder.encodeObject(self.state, forKey: "state")
    aCoder.encodeObject(self.locked, forKey: "locked")
    aCoder.encodeObject(self.assignee, forKey: "assignee")
    aCoder.encodeObject(self.milestone, forKey: "milestone")
    aCoder.encodeObject(self.created_at, forKey: "created_at")
    aCoder.encodeObject(self.updated_at, forKey: "updated_at")
    aCoder.encodeObject(self.closed_at, forKey: "closed_at")
    aCoder.encodeObject(self.diff_url, forKey: "diff_url")
    aCoder.encodeObject(self.patch_url, forKey: "patch_url")
    aCoder.encodeObject(self.pullRequest_url, forKey: "pullRequest_url")
    aCoder.encodeObject(self.merge_commit_sha, forKey: "merge_commit_sha")
    aCoder.encodeObject(self.merged_at, forKey: "merged_at")
  }
}