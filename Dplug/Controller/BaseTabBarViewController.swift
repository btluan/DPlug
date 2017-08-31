//
//  BaseTabBarViewController.swift
//  Dplug
//
//  Created by Lan Tran on 8/20/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstNavigation = UINavigationController()
        let secondNavigation = UINavigationController()
        let thirdNavigation = UINavigationController()
        let fourNavigation = UINavigationController()
        
        let firstViewController = HomeViewController()
        let secondViewController = PostViewController()
        let thirdViewController = ConversationViewController()
        let fourViewController = UserProfileViewController()
        
        firstNavigation.viewControllers = [firstViewController]
        secondNavigation.viewControllers = [secondViewController]
        thirdNavigation.viewControllers = [thirdViewController]
        fourNavigation.viewControllers = [fourViewController]
        
        firstNavigation.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named:"Home"), tag: 1)
        secondNavigation.tabBarItem = UITabBarItem(title: "Post", image: UIImage(named:"Capture"), tag: 1)
        thirdNavigation.tabBarItem = UITabBarItem(title: "Conversation", image: UIImage(named:"Message"), tag: 1)
        fourNavigation.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named:"User"), tag: 1)
        
        
        
        self.tabBar.tintColor = UIColor.black
        self.tabBar.barTintColor = UIColor.white
        
        self.viewControllers = [firstNavigation, secondNavigation, thirdNavigation, fourNavigation]
        
        // Do any additional setup after loading the view.
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
