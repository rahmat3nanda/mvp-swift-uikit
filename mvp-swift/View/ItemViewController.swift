//
//  ItemViewController.swift
//  mvp-swift
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/22.
//

import Foundation
import UIKit

protocol ItemViewDelegate: AnyObject{
    func onItemsRetrieval(titles: [String])
    func onItemAddSuccess(title: String)
    func onItemAddFailure(message: String)
    func onItemDeletion(index: Int)
}

class ItemViewController: UIViewController{
    var presenter: ItemPresenterDelegate!
    private var titles: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        presenter.viewDidLoad()
        titles = []
    }
    
    // MARK: - Actions
    @objc func addTapped() {
        let alert = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let add = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let title = alert.textFields?.first!.text, !title.isEmpty {
                self?.presenter.addTapped(with: title)
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Item's title"
        }
        
        alert.addAction(cancel)
        alert.addAction(add)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func mainView() -> ItemView? {
        if let view = (presenter as? ItemPresenter)?.view as? ItemView {
            return view
        }
        return nil
    }
}

//  MARK: - TableView DataSource
extension ItemViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let view = mainView() {
            view.tableView.isHidden = titles.isEmpty
            view.placeholderLabel.isHidden = !titles.isEmpty
        }
        
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainView()!.tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteSelected(for: indexPath.row)
        }
    }
}

// MARK: - Protocol
extension ItemViewController: ItemViewDelegate{
    func onItemsRetrieval(titles: [String]) {
        self.titles = titles
        mainView()?.tableView.reloadData()
    }
    
    func onItemAddSuccess(title: String) {
        titles.append(title)
        mainView()?.tableView.reloadData()
    }
    
    func onItemAddFailure(message: String) {
        print("Failure add item")
    }
    
    func onItemDeletion(index: Int) {
        titles.remove(at: index)
        mainView()?.tableView.reloadData()
    }
}
