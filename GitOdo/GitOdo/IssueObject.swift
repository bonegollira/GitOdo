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
  let labels: [LabelObject]
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
    self.labels = issue["labels"].arrayValue.map{ LabelObject($0) }
    self.state = issue["state"].stringValue
    self.locked = issue["locked"].boolValue
    self.assignee = issue["assignee"].string
    self.milestone = issue["milestone"].string
    self.created_at = issue["created_at"].stringValue
    self.updated_at = issue["updated_at"].stringValue
    self.closed_at = issue["closed_at"].string
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    self.type = ToDoType.fromInt(aDecoder.decodeObjectForKey("type") as! Int)
    self.html_url = aDecoder.decodeObjectForKey("html_url") as! String
    self.number = aDecoder.decodeObjectForKey("number") as! Int
    self.title = aDecoder.decodeObjectForKey("title") as! String
    self.body = aDecoder.decodeObjectForKey("body") as? String
    self.comments = aDecoder.decodeObjectForKey("comments") as! Int
    
    self.url = aDecoder.decodeObjectForKey("url") as! String
    self.labels_url = aDecoder.decodeObjectForKey("labels_url") as! String
    self.comments_url = aDecoder.decodeObjectForKey("comments_url") as! String
    self.events_url = aDecoder.decodeObjectForKey("events_url") as! String
    self.id = aDecoder.decodeObjectForKey("id") as! Int
    self.user = aDecoder.decodeObjectForKey("user") as! UserObject
    self.labels = aDecoder.decodeObjectForKey("labels") as! [LabelObject]
    self.state = aDecoder.decodeObjectForKey("state") as! String
    self.locked = aDecoder.decodeObjectForKey("locked") as! Bool
    self.assignee = aDecoder.decodeObjectForKey("assignee") as? String
    self.milestone = aDecoder.decodeObjectForKey("milestone") as? String
    self.created_at = aDecoder.decodeObjectForKey("created_at") as! String
    self.updated_at = aDecoder.decodeObjectForKey("updated_at") as! String
    self.closed_at = aDecoder.decodeObjectForKey("closed_at") as? String
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.type.rawValue, forKey: "type")
    aCoder.encodeObject(self.html_url, forKey: "html_url")
    aCoder.encodeObject(self.number, forKey: "number")
    aCoder.encodeObject(self.title, forKey: "title")
    aCoder.encodeObject(self.body, forKey: "body")
    aCoder.encodeObject(self.comments, forKey: "comments")
    
    aCoder.encodeObject(self.url, forKey: "url")
    aCoder.encodeObject(self.labels_url, forKey: "labels_url")
    aCoder.encodeObject(self.comments_url, forKey: "comments_url")
    aCoder.encodeObject(self.events_url, forKey: "events_url")
    aCoder.encodeObject(self.id, forKey: "id")
    aCoder.encodeObject(self.user, forKey: "user")
    aCoder.encodeObject(self.labels, forKey: "labels")
    aCoder.encodeObject(self.state, forKey: "state")
    aCoder.encodeObject(self.locked, forKey: "locked")
    aCoder.encodeObject(self.assignee, forKey: "assignee")
    aCoder.encodeObject(self.milestone, forKey: "milestone")
    aCoder.encodeObject(self.created_at, forKey: "created_at")
    aCoder.encodeObject(self.updated_at, forKey: "updated_at")
    aCoder.encodeObject(self.closed_at, forKey: "closed_at")
  }
  
}