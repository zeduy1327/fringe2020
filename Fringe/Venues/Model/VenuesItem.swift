//
//  VenuesItem.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import Foundation
import SwiftyJSON

class VenuesItem: NSObject {
    
    var id: Int = 0
    var name: String = ""
    var latitude: Double = 0
    var longitude: Double = 0
    
    override init() {
        super.init()
    }
    
    init (_ item: JSON) {
        id = item["id"].intValue
        name = item["name"].stringValue
        latitude = item["latitude"].doubleValue
        latitude = item["latitude"].doubleValue
    }
}
