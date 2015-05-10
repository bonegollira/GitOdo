//
//  IssueObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

class IssueObject: NSObject, ToDoObjectProtocol {
  
  // MARK: ToDoObjectProtocol
  let type: ToDoType
  let html_url: String
  let number: Int
  let title: String
  let body: String?
  let comments: Int
  
  // MARK: IssueObject
  let url: String
  let labels_url: String
  let comments_url: String
  let events_url: String
  let id: Int
  let user: UserObject
  let labels: JSON
  let state: String
  let locked: Bool
  let assignee: String?
  let milestone: String?
  let created_at: String
  let updated_at: String
  let closed_at: String?
  
  init (_ issue :JSON) {
    self.type = .Issue
    self.html_url = issue["html_url"].stringValue
    self.number = issue["number"].intValue
    self.title = issue["title"].stringValue
    self.body = issue["body"].string
    self.comments = issue["comments"].int ?? 0
    
    self.url = issue["url"].stringValue
    self.labels_url = issue["labels_url"].stringValue
    self.comments_url = issue["comments_url"].stringValue
    self.events_url = issue["events_url"].stringValue
    self.id = issue["id"].intValue
    self.user = UserObject(JSON(issue["user"].dictionaryObject!))
    self.labels = issue["labels"]
    self.state = issue["state"].stringValue
    self.locked = issue["locked"].boolValue
    self.assignee = issue["assignee"].string
    self.milestone = issue["milestone"].string
    self.created_at = issue["created_at"].stringValue
    self.updated_at = issue["updated_at"].stringValue
    self.closed_at = issue["closed_at"].string
    super.init()
  }
   
}