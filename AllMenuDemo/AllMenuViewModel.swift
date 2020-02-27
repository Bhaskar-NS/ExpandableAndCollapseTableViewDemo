//
//  AllMenuViewModel.swift
//  AllMenuDemo
//
//  Created by Bhaskar on 26/06/19.
//  Copyright © 2019 Bhaskar. All rights reserved.
//

import Foundation
import UIKit


protocol AllMenuViewModelItem {
    var rowCount: Int { get }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
}


class AllMainMenuViewModel: NSObject {
    var allMenuList = [AllMenuViewModelItem]()
    
    var reloadSections: ((_ section: Int) -> Void)?
    
    override init() {
        guard let data = dataFromFile("AllMenu"),
            let allMenu = AllMenuModel(data: data) else {
                return
        }
        print(allMenu.allMenuItem)        
        
        for mainCategory in allMenu.allMenuItem {
            allMenuList.append(MainMenuViewModel(model: mainCategory))
        }
        print(allMenuList)
    }
}

extension AllMainMenuViewModel: HeaderViewDelegate {
    func toggleSection(header: HeaderView, section: Int) {
        var item = allMenuList[section]
        if item.isCollapsible {
            
            let collapsed = !item.isCollapsed
            item.isCollapsed = collapsed
            header.setCollapsed(collapsed: collapsed)
            
            reloadSections?(section)
        }
    }
}

extension AllMainMenuViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView {
            let item = allMenuList[section]
            
            headerView.item = item
            headerView.section = section
            headerView.delegate = self
            return headerView
        }
        return UIView()
    }
}

extension AllMainMenuViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allMenuList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = allMenuList[section]
        guard item.isCollapsible else {
            return item.rowCount
        }
        if item.isCollapsed {
            return 0
        } else {
            return item.rowCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = allMenuList[indexPath.section]
        if let item = item as? MainMenuViewModel,
            let mainCategoryCell = tableView.dequeueReusableCell(withIdentifier: MainCategoryTableViewCell.identifier, for: indexPath) as? MainCategoryTableViewCell {
            
            mainCategoryCell.item = item
            
            if !item.subCategory.isEmpty,
                let cell = tableView.dequeueReusableCell(withIdentifier: SubCategoryTableViewCell.identifier, for: indexPath) as? SubCategoryTableViewCell {
                cell.item = item.subCategory[indexPath.row]
                return cell
            }
            return mainCategoryCell
        }
        return UITableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let item = allMenuList[section] as? MainMenuViewModel
//        return item?.name
//    }
}

extension AllMenuViewModelItem {
    var rowCount: Int {
        return 1
    }
    
    var isCollapsible: Bool {
        return true
    }
}

//class AllMenuViewModel: AllMenuViewModelItem {
//    var allMenuItem = [AllMenuViewModelItem]()
//    init(list: AllMenuModel) {
//        self.allMenuItem = list.allMenuItem.map{ MainMenuViewModel(model: $0)}
//    }
//}


class MainMenuViewModel: AllMenuViewModelItem {
    var name: String
    var subCategory = [SubCategoryMenuViewModel]()
    
    var rowCount: Int {
        return subCategory.count
    }
    
    var isCollapsed = true
    
    init(model: MainMenuModel) {
        self.name = model.name ?? ""
        if let category = model.subCategory {
            for category in category {
                subCategory.append(SubCategoryMenuViewModel(model: category))
            }
        }
    }
}

class SubCategoryMenuViewModel: AllMenuViewModelItem {
    var name: String?
    var displayName: String?
    var isCollapsed = true
    
    init(model: SubCategoryMenuModel) {
        self.name = model.name ?? ""
        self.displayName = model.displayName ?? ""
    }
}
