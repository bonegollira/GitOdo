//
//  LabelObject.swift
//  GitOdo
//
//  Created by daisuke on 2015/05/11.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import SwiftyJSON

class LabelObject: NSObject, NSCoding {
  
  let url: String
  let name: String
  let color: String
  
  init (_ label: JSON) {
    self.url = label["url"].stringValue
    self.name = label["name"].stringValue
    self.color = label["color"].stringValue
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    self.url = aDecoder.decodeObjectForKey("url") as! String
    self.name = aDecoder.decodeObjectForKey("name") as! String
    self.color = aDecoder.decodeObjectForKey("color") as! String
  }
  
  func encodeWithCoder(aCoder: NSCoder) {
    aCoder.encodeObject(self.url, forKey: "url")
    aCoder.encodeObject(self.name, forKey: "name")
    aCoder.encodeObject(self.color, forKey: "color")
  }
}