//
//  CategoriesModel.swift
//  Dplug
//
//  Created by Lan Tran on 9/1/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class CategoriesModel: NSObject {
    var id: String?
    var name: String?
    var image: String?
    
    func parseCategories(data: NSDictionary) -> [CategoriesModel] {
        let categoriesData = data["categories"] as! NSArray
        var categories: [CategoriesModel] = []
        for i in 0 ..< categoriesData.count {
            let dictionaryCat = categoriesData[i] as! NSDictionary
            let itemCat = CategoriesModel()
            
            itemCat.id = dictionaryCat["_id"] as? String
            itemCat.name = dictionaryCat["name"] as? String
            itemCat.image = dictionaryCat["image"] as? String
            categories.append(itemCat)
        }
        return categories
    }
}
