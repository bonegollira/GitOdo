//
//  AppDelegate.swift
//  GitOdo
//
//  Created by daisuke on 2015/02/21.
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    UINavigationBar.appearance().barTintColor = rgba(44, g: 93, b: 142)
    UINavigationBar.appearance().tintColor = rgba(255, g: 255, b: 255)
    UINavigationBar.appearance().titleTextAttributes = [
      NSForegroundColorAttributeName: rgba(255, g: 255, b: 255)
    ]
    UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarPosition: .Any, barMetrics: .Default)
    UINavigationBar.appearance().shadowImage = UIImage()
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    UIApplication.sharedApplication().idleTimerDisabled = false
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    UIApplication.sharedApplication().idleTimerDisabled = true
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    UIApplication.sharedApplication().idleTimerDisabled = true
  }
  
  func applicationWillTerminate(application: UIApplication) {
    UIApplication.sharedApplication().idleTimerDisabled = false
  }
}

