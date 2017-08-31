//
//  BaseViewController.swift
//  Dplug
//
//  Created by Lan Tran on 8/20/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension BaseViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        // do aditional stuff
    }
    
    func test() {
        print("Luan ngu")
    }
}
