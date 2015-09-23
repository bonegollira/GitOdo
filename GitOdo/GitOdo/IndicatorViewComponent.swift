//
//  IndicatorViewComponent.swift
//  GitOdo
//
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit
import Cartography

extension IndicatorViewComponent: ViewComponentsDequeueLayout {
  
  func configure__self () {
    self.backgroundColor = rgba(44, g: 93, b: 142)
    self.layer.masksToBounds = true
    self.layer.cornerRadius = 5.0
  }
  
  func configure__indicatorView () {
    self.indicatorView.activityIndicatorViewStyle = .White
  }
  
  func autolayout__indicatorView () {
    constrain(self.indicatorView) { indicatorView in
      indicatorView.center == indicatorView.superview!.center
      indicatorView.width == 32
      indicatorView.height == 32
    }
  }
  
  func render () {
    self.addSubview(self.indicatorView)
    self.configure__self()
    self.configure__indicatorView()
    self.autolayout__indicatorView()
  }
  
}

class IndicatorViewComponent: UIView {
  
  struct IndicatorViewComponentInstance {
    static let instance = IndicatorViewComponent()
  }
  
  class func sharedInstance () -> IndicatorViewComponent {
    return IndicatorViewComponentInstance.instance
  }
  
  let indicatorView = UIActivityIndicatorView()
  var isStarting = false
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init() {
    super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    self.render()
  }
  
  class func start () {
    if !IndicatorViewComponent.sharedInstance().isStarting {
      IndicatorViewComponent.sharedInstance().isStarting = true
      IndicatorViewComponent.sharedInstance().start()
    }
  }
  
  class func stop () {
    if IndicatorViewComponent.sharedInstance().isStarting {
      IndicatorViewComponent.sharedInstance().isStarting = false
      IndicatorViewComponent.sharedInstance().stop()
    }
  }
  
  func start () {
    if let center = UIApplication.sharedApplication().keyWindow?.center {
      self.center = center
    }
    UIApplication.sharedApplication().keyWindow?.addSubview(self)
    self.indicatorView.startAnimating()
  }
  
  func stop () {
    self.removeFromSuperview()
    self.indicatorView.stopAnimating()
  }
}
