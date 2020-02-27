//
//  ViewController.swift
//  AllMenuDemo
//
//  Created by Bhaskar on 26/06/19.
//  Copyright © 2019 Bhaskar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var viewModel = AllMainMenuViewModel()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initialSetup()
        
        viewModel.reloadSections = { [weak self] (section: Int) in
            self?.tableView.beginUpdates()
            self?.tableView.reloadSections([section], with: .fade)
            self?.tableView.endUpdates()
        }
    }
    
    func initialSetup() {
        
        registerTableViewCells()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.estimatedRowHeight = 100
        tableView.sectionHeaderHeight = 70.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerTableViewCells() {
        tableView?.register(MainCategoryTableViewCell.nib, forCellReuseIdentifier: MainCategoryTableViewCell.identifier)
        tableView?.register(SubCategoryTableViewCell.nib, forCellReuseIdentifier: SubCategoryTableViewCell.identifier)
        tableView?.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
    }
}

