//
//  Item.swift
//  mvp-swift
//
//  Created by Rahmat Trinanda Pramudya Amar on 19/07/22.
//

import Foundation
import RealmSwift

class ItemModel: Object {
    @objc dynamic var title: String = ""
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
