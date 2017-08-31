//
//  UserModel.swift
//  Dplug
//
//  Created by Lan Tran on 8/31/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit
import ObjectMapper

class UserModel: NSObject {
    var id: String?
    var username: String?
    var avata: String?
    var token: String?
    
    func parseUser(data: NSDictionary){
        token = data["token"] as? String
        let user = data["user"] as? NSDictionary
        id = user?["_id"] as? String
        username = user?["username"] as? String
        let profile = user?["profile"] as? NSDictionary
        if let tempAvata = profile?["picture"] as? String {
            avata = tempAvata
        } else {
            avata = ""
        }
    }
}
