//
//  FringeEventModel.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import Foundation
import SwiftyJSON

class FringeEventModel: NSObject {
    
    var items: [FringeEventItem] = []
    
    override init() {
        super.init()
    }
    
    func setData(_ data: JSON) {
        removeAll()
        let tmp_arr = data.arrayValue
        tmp_arr.forEach { (item) in
            items.append(FringeEventItem(item))
        }
    }
    
    func getItemAt(_ index: Int) -> FringeEventItem{
        return items[index]
    }
    
    func setItem(_ item: FringeEventItem) {
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
    
    func getRandomizeItems() -> [FringeEventItem] {
        return items.shuffled()
    }
    
    func removeAll() {
        items = []
    }
}
