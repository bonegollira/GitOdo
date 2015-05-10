//
//  ToDoObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/05/05.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import Foundation
import SwiftyJSON

/*!

  protocol<ToDoObjectProtocol>

 */
@objc protocol ToDoObjectProtocol: NSObjectProtocol {
  var type: ToDoType { get }
  var html_url: String { get }
  var number: Int { get }
  var title: String { get }
  var body: String? { get }
  var comments: Int { get }
}

@objc enum ToDoType: Int {
  case PullRequest = 0
  case Issue = 1
}

func == (lhs: ToDoType, rhs: ToDoType) -> Bool {
  return lhs.rawValue == rhs.rawValue
}

func > (lhs: ToDoType, rhs: ToDoType) -> Bool {
  return lhs.rawValue > rhs.rawValue
}

func >= (lhs: ToDoType, rhs: ToDoType) -> Bool {
  return lhs.rawValue >= rhs.rawValue
}

func < (lhs: ToDoType, rhs: ToDoType) -> Bool {
  return lhs.rawValue < rhs.rawValue
}

func <= (lhs: ToDoType, rhs: ToDoType) -> Bool {
  return lhs.rawValue <= rhs.rawValue
}