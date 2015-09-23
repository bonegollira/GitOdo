//
//  WKWebViewController.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/14.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit
import WebKit
import Cartography

extension WKWebViewController: ViewControllerLayout {
  
  func configure__self () {
    self.view.backgroundColor = rgba(255, g: 255, b: 255)
  }
  
  func autolayout__webView () {
    constrain(self.webView) { webView in
      webView.edges == webView.superview!.edges
      return
    }
  }
  
  func render () {
    self.view.addSubview(self.webView)
    self.configure__self()
    self.autolayout__webView()
  }
  
}

class WKWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
  
  let webView = WKWebView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.webView.navigationDelegate = self
    self.webView.UIDelegate = self
    self.render()
  }
  
  override func viewDidDisappear(animated: Bool) {
    self.webView.stopLoading()
    IndicatorViewComponent.stop()
    super.viewDidDisappear(animated)
  }
  
  func loadURLString (URLString: String) {
    let URL = NSURL(string: URLString)!
    let request = NSURLRequest(URL: URL)
    self.webView.loadRequest(request)
  }
  
  func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    IndicatorViewComponent.start()
  }
  
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    IndicatorViewComponent.stop()
  } 
}
