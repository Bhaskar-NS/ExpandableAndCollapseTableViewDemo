//
//  MainCategoryTableViewCell.swift
//  AllMenuDemo
//
//  Created by Bhaskar on 27/06/19.
//  Copyright © 2019 Bhaskar. All rights reserved.
//

import UIKit

class MainCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var menuName: UILabel!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var item: AllMenuViewModelItem? {
        didSet {
            guard  let item = item as? MainMenuViewModel else {
                return
            }
            
            menuName.text = item.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
