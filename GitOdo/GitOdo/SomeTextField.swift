//
//  SomeTextField.swift
//  GitOdo
//
//  Created by daisuke on 2015/03/22.
//  Copyright (c) 2015年 daisuke. All rights reserved.
//

import UIKit

struct SomeTextFieldConfigure {
  let id: String
  let placeholder: String?
  let required: Bool = false
}

class SomeTextField: UITextField {

  let configure: SomeTextFieldConfigure
  
  required init(coder aDecoder: NSCoder) {
    self.configure = SomeTextFieldConfigure(id: "", placeholder: "", required: false)
    super.init(coder: aDecoder)
  }
  
  init (configure: SomeTextFieldConfigure) {
    self.configure = configure
    super.init(frame: CGRectZero)
    self.placeholder = configure.placeholder
  }

}
