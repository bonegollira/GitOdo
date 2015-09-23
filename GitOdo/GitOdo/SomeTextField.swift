//
//  SomeTextField.swift
//  GitOdo
//
//  Copyright (c) 2015 daisuke. All rights reserved.
//

import UIKit

struct SomeTextFieldConfigure {
  let id: String
  let placeholder: String
  let required: Bool
}

class SomeTextField: UITextField {

  let configure: SomeTextFieldConfigure
  
  required init?(coder aDecoder: NSCoder) {
    self.configure = SomeTextFieldConfigure(id: "", placeholder: "", required: false)
    super.init(coder: aDecoder)
  }
  
  init (configure: SomeTextFieldConfigure) {
    self.configure = configure
    super.init(frame: CGRectZero)
    self.placeholder = configure.placeholder
  }

}
