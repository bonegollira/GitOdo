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
//import Alamofire_SwiftyJSON
import Dollar

class GithubConnection: NSObject {
  
  private struct GithubConnectionProperty {
    static var requestingCount = 0
  }
  
  class var requestingCount: Int {
    return GithubConnectionProperty.requestingCount
  }
  
  class func URLRequest (entrypoint: String, headers: [String: String] = [:]) -> NSURLRequest {
    let URL = NSURL(string: entrypoint)!
    let request = NSMutableURLRequest(
      URL: URL,
      cachePolicy: .ReloadIgnoringLocalCacheData,
      timeoutInterval: 5.0
    )
    for (field, value) in headers {
      request.addValue(value, forHTTPHeaderField: field)
    }
    
    return request
  }
  
  class func activeIndicator () -> (NSURLRequest?, NSHTTPURLResponse?, NSData?, ErrorType?) -> Void {
    let app = UIApplication.sharedApplication()
    app.networkActivityIndicatorVisible = true
    GithubConnectionProperty.requestingCount++
    
    return {(_: NSURLRequest?, _: NSHTTPURLResponse?, _: NSData?, _: ErrorType?) -> Void in
      app.networkActivityIndicatorVisible = !(--GithubConnectionProperty.requestingCount == 0)
    }
  }
  
  class func request (entrypoint: String, parameters: [String: String] = [:]) -> Alamofire.Request {
    let request = GithubConnection.URLRequest(entrypoint, headers: parameters)
    let inactiveIndicator = GithubConnection.activeIndicator()
    
    return Alamofire
      .request(request)
      .response(completionHandler: inactiveIndicator)
  }
  
  private class func requestRepo<T> (type: String, repository: RepositoryObject, callback: ([T]) -> Void, transformer: (JSON) -> T) {
    if let github = ArchiveConnection.sharedInstance().getGithub(repository: repository) {
      let entrypoint = github.api(type, repo: repository.owerRepo)
      let parameters = [
        "Authorization": "token \(github.accessToken)"
      ]
      
      GithubConnection
        .request(entrypoint, parameters: parameters)
        .responseJSON(completionHandler: {(request, responce, anyObject) in
          if let arrayObject = anyObject.value as? Array<AnyObject> {
            let arguments = $.map(arrayObject, transform: { (rawObject:AnyObject) -> T in
              return transformer(JSON(rawObject))
            })
            callback(arguments)
          }
        })
    }
  }
  
  class func requestIssues (repository: RepositoryObject, callback: ([IssueObject]) -> Void) {
    return GithubConnection.requestRepo("issues",
      repository: repository,
      callback: callback,
      transformer: { IssueObject($0) }
    )
  }
  
  class func requestPullRequests (repository: RepositoryObject, callback: ([PullRequestObject]) -> Void) {
    return GithubConnection.requestRepo("pulls",
      repository: repository,
      callback: callback,
      transformer: { PullRequestObject($0) }
    )
  }
  
  class func requestGravatar (gravatar: String, callback: (UIImage) -> Void) {
    Alamofire
      .request(.GET, gravatar)
      .response(completionHandler: { (request, responce, data, error) in
        if let image = UIImage(data: data!) {
          callback(image)
        }
      })
  }
}
