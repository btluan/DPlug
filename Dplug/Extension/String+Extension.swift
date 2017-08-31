//
//  String+Extension.swift
//  Dplug
//
//  Created by Lan Tran on 8/27/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//
import UIKit

extension String {
    func isUsername() -> Bool {
        return self.characters.count >= 3
    }
    
    func isPassword() -> Bool {
        return self.characters.count >= 6
    }
    
    func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return email.evaluate(with: self)
    }
}
