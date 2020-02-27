//
//  SubCategoryTableViewCell.swift
//  AllMenuDemo
//
//  Created by Bhaskar on 27/06/19.
//  Copyright © 2019 Bhaskar. All rights reserved.
//

import UIKit

class SubCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var item: AllMenuViewModelItem? {
        didSet {
            guard  let item = item as? SubCategoryMenuViewModel else {
                return
            }
            nameLabel.text = item.name
            displayNameLabel.text = item.displayName
            
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
