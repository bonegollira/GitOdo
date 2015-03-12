//
//  GithubConnection.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/22.
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GithubConnection: NSObject {
  
  /*! Github Api Url smaples
  
  * issues
  https://api.github.com/repos/${user}/${repo}/issues
  https://api.github.com/repos/bonegollira/GitOdo.dev/issues
  
  */
  
  class func requestIssues (repository: RepositoryObject, callback: ([IssueObject]) -> Void) {
    Alamofire
      .request(.GET, repository.issuesApi)
      .responseJSON({ (_, _, any, error) in
        var issues: [IssueObject] = []
        
        if let array = any? as? Array<AnyObject> {
          for issue in array {
            issues.append(
              IssueObject(issue: JSON(issue))
            )
          }
        }
        
        callback(issues)
      })
  }
}
