//
//  Common.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/07.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

public func rgba(r: Int, g: Int, b: Int, a: CGFloat = 1.0) -> UIColor {
  let red = CGFloat(r)
  let green = CGFloat(g)
  let blue = CGFloat(b)
  return UIColor(
    red: CGFloat(red / 255),
    green: CGFloat(green / 255),
    blue: CGFloat(blue / 255),
    alpha: a
  )
}