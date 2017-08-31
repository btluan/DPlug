//
//  OnBoardingScreenViewController.swift
//  Dplug
//
//  Created by Lan Tran on 8/16/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class OnBoardingScreenViewController: UIViewController {
    
    let contain: String = "Easiest and coolest way to manage your classifieds"
    
    @IBOutlet weak var titleApp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleApp.text = contain
        // Do any additional setup after loading the view.
    }

    @IBAction func clickBtnContinue(_ sender: Any) {

        UserDefaults.standard.set("only one", forKey: "name")
        let vc = LoginViewController()
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
