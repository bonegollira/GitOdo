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
  
  private struct GithubConnectionProperty {
    static var requestingCount = 0
  }
  
  class var requestingCount: Int {
    return GithubConnectionProperty.requestingCount
  }
  
  class func request (entrypoint: String, parameters: [String: AnyObject]?) -> Alamofire.Request {
    let app = UIApplication.sharedApplication()
    app.networkActivityIndicatorVisible = true
    GithubConnectionProperty.requestingCount++
    
    return Alamofire
      .request(.GET, entrypoint, parameters: parameters)
      .response({ (this, arguments, dont, use) in
        app.networkActivityIndicatorVisible = !(--GithubConnectionProperty.requestingCount == 0)
      })
  }
  
  class func requestIssues (repository: RepositoryObject, callback: ([IssueObject]) -> Void) {
    
    if let github = ArchiveConnection.sharedInstance().getGithub(repository) {
      let entrypoint = github.api("issues", repo: repository.owerRepo)
      let parameters = [
        "access_token": github.accessToken
      ]
      
      GithubConnection
        .request(entrypoint, parameters: parameters)
        .responseJSON({ (request, responce, anyObject, error) in
          if let array = anyObject as? Array<AnyObject> {
            var issues = array.map({ IssueObject(issue: JSON($0)) })
            callback(issues)
          }
          else  {
            callback([IssueObject]())
          }
        })
    }
    else {
      callback([IssueObject]())
    }
  }
  
  class func requestPullRequests (repository: RepositoryObject, callback: ([PullRequestObject]) -> Void) {
    
    if let github = ArchiveConnection.sharedInstance().getGithub(repository) {
      let entrypoint = github.api("pulls", repo: repository.owerRepo)
      let parameters = [
        "access_token": github.accessToken
      ]
      
      GithubConnection
        .request(entrypoint, parameters: parameters)
        .responseJSON({ (request, responce, anyObject, error) in
          if let array = anyObject as? Array<AnyObject> {
            var pullRequests = array.map({ PullRequestObject(pullRequest: JSON($0)) })
            callback(pullRequests)
          }
          else {
            callback([PullRequestObject]())
          }
        })
    }
    else {
      callback([PullRequestObject]())
    }
  }
  
  class func requestGravatar (gravatar: String, callback: (UIImage) -> Void) {
    Alamofire
      .request(.GET, gravatar)
      .response({ (request, responce, data, error) in
        if let image = UIImage(data: data? as NSData) {
          callback(image)
        }
      })
  }
}