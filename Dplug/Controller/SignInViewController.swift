//
//  SignInViewController.swift
//  Dplug
//
//  Created by Lan Tran on 8/19/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import ObjectMapper

class SignInViewController: BaseViewController {

    //var tabBar = UITabBarController()
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func eventLogin(_ sender: Any) {
        
        guard let username = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if !username.isUsername() || !password.isPassword() {
            print("username or password invalid")
            return
        }
        
        APIService.shareInstance.signInEmail(username: username, password: password, completion: { result in
            if let data = result as? NSDictionary {
                ShareInstanceModel.shareInstance.currentUser?.parseUser(data: data)
            }
            self.loginSuccess()
        }) { message in
            print("eventLogin - error message: \(message)")
        }
    }

    @IBAction func eventLoginFacebook(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            
            switch loginResult {
            case .failed(let error):
                print(error)
                
            case .cancelled:
                print("User cancelled login.")
                
            case .success(let grantedPermissions, let declinedPermissions ,let token):
                print("success: \(grantedPermissions) -- \(declinedPermissions) -- \(token)")
                self.loginSuccess()
            }
        }
    }
    
    @IBAction func eventBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignInViewController {
    func loginSuccess(){
        let tabBar = BaseTabBarViewController()
        self.present(tabBar, animated: true, completion: nil)
    }
}
