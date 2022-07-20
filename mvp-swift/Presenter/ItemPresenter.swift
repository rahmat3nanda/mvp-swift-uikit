//
//  ItemPresenter.swift
//  mvp-swift
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/22.
//

import Foundation
import RealmSwift

protocol ItemPresenterDelegate: AnyObject {
    init(view: ItemViewDelegate)
    func viewDidLoad()
    func addTapped(with title: String)
    func deleteSelected(for index: Int)
}

class ItemPresenter: ItemPresenterDelegate{
    weak var view: ItemViewDelegate?
    
    private var items: Results<ItemModel>?
    private var realm = try! Realm()
    
    required init(view: ItemViewDelegate) {
        self.view = view
    }
    
    func viewDidLoad() {
        retriveItems()
    }
    
    func addTapped(with title: String) {
        addItem(title: title)
    }
    
    func deleteSelected(for index: Int) {
        deleteItem(at: index)
    }
}

// MARK: - Private Zone
private extension ItemPresenter{
    func retriveItems(){
        items = realm.objects(ItemModel.self)
        
        let titles: [String]? = items?.compactMap { $0.title }
        view?.onItemsRetrieval(titles: titles ?? [])
    }
    
    func addItem(title: String){
        let item = ItemModel(title: title)
        
        do {
            try realm.write{
                realm.add(item)
            }
        }catch{
            view?.onItemAddFailure(message: error.localizedDescription)
        }
        view?.onItemAddSuccess(title: item.title)
    }
    
    func deleteItem(at index: Int){
        if let items = items {
            do {
                try realm.write {
                    realm.delete(items[index])
                }
            }catch{
                print("Failure delete")
            }
            view?.onItemDeletion(index: index)
        }
    }
}
