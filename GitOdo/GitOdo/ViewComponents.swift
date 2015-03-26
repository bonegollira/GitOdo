//
//  ViewComponents.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/23.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

protocol ViewControllerLayout {
  func render ()
}

protocol ViewComponentsLayout {
  func render (parentView: UIView)
}

protocol ViewComponentsDequeueLayout: ViewControllerLayout {
}

class ViewComponents: NSObject {
   
}
