//
//  ToDoObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/05/05.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol ToDoObjectProtocol: NSObjectProtocol {
  var type: String { get }
  var html_url: String { get }
  var number: Int { get }
  var title: String { get }
  var body: String? { get }
  var comments: Int { get }
}

class ToDoObject: NSObject {
  
  let type: String
  let html_url: String
  let number: Int
  let title: String
  let body: String?
  let comments: Int
  
  init (todo: JSON, type: String) {
    self.type = type
    self.html_url = todo["html_url"].stringValue
    self.number = todo["number"].intValue
    self.title = todo["title"].stringValue
    self.body = todo["body"].string
    self.comments = todo["comments"].int ?? 0
    super.init()
  }
  
}