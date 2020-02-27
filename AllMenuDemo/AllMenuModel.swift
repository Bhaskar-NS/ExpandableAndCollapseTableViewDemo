//
//  MenuModel.swift
//  AllMenuDemo
//
//  Created by Bhaskar on 26/06/19.
//  Copyright © 2019 Bhaskar. All rights reserved.
//

import Foundation

public func dataFromFile(_ filename: String) -> Data? {
    let bundle = Bundle.main
    if let path = bundle.path(forResource: filename, ofType: "json") {
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
    return nil
}

class AllMenuModel {
    var allMenuItem = [MainMenuModel]()
    
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                allMenuItem = json.map{ MainMenuModel(json: $0) }
                print(allMenuItem)
            }
        }
        catch {
            print(error)
            return nil
        }
    }
}


class MainMenuModel {
    var name: String?
    var subCategory: [SubCategoryMenuModel]?
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String
        if let subCategory = json["sub_category"] as? [[String : Any]] {
            self.subCategory = subCategory.map{ SubCategoryMenuModel(json: $0 )}
        }
    }
    
}

class SubCategoryMenuModel {
    var name: String?
    var displayName: String?
    
    init(json: [String: Any]) {
        self.name = json["name"] as? String
        self.displayName = json["display_name"] as? String
    }
}
