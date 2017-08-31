//
//  TextField.swift
//  Dplug
//
//  Created by Lan Tran on 8/20/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class TextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = Constant.mainTextColor
        self.font = Constant.mediumFontNomal
        self.autocorrectionType = .no
        
    }

}
