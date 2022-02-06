//
//  VenuesModel.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import Foundation
import SwiftyJSON

class VenuesModel: NSObject {
    
    var items: [VenuesItem] = []
    
    override init() {
        super.init()
    }
    
    func setData(_ data: JSON) {
        removeAll()
        let tmp_arr = data.arrayValue
        tmp_arr.forEach { (item) in
            items.append(VenuesItem(item))
        }
    }
    
    func getItems() -> [VenuesItem] {
        return items
    }
    
    func getItemAt(_ index: Int) -> VenuesItem{
        return items[index]
    }
    
    func setItem(_ item: VenuesItem) {
        let index = items.firstIndex { (tmp) -> Bool in
            return tmp.id == item.id
        }
        if index != nil {
            items[index!] = item
        }
    }
    
    func getCount() -> Int {
        return items.count
    }
    
    func removeAll() {
        items = []
    }
}

