//
//  ShareInstanceModel.swift
//  Dplug
//
//  Created by Lan Tran on 9/1/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class ShareInstanceModel: NSObject {
    static let shareInstance = ShareInstanceModel()
    var currentUser: UserModel?
    var categories: [CategoriesModel]?
    
}
