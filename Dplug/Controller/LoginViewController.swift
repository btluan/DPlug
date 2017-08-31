//
//  LoginViewController.swift
//  Dplug
//
//  Created by Lan Tran on 8/16/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    let infor: String = "By Signing up, you agree to our "
    var priPolyci: String = "Terms & Privacy Polyci"
    @IBOutlet weak var privacyPolicy: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let attributedString = NSMutableAttributedString(string:infor)
        let attrs = [NSFontAttributeName : Constant.smallFontBold]
        let boldString = NSMutableAttributedString(string:priPolyci, attributes:attrs)
        
        attributedString.append(boldString)
        privacyPolicy.attributedText = attributedString

    }

    @IBAction func eventRegister(_ sender: Any) {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func eventLogin(_ sender: Any) {
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
