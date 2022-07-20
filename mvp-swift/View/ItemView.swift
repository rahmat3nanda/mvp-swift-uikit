//
//  ItemView.swift
//  mvp-swift
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/22.
//

import Foundation
import UIKit

class ItemView: UIView{
    lazy var addBarItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Add", style: .plain, target: nil, action: nil)
        item.tintColor = .systemYellow
        return item
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView
            .translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .darkGray
        label.text = "No stored items yet"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
