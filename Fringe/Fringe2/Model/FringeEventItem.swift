//
//  FringeEventItem.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import Foundation
import SwiftyJSON

class FringeEventItem: NSObject {
    
    var id: Int = 0
    var name: String = ""
    var artist: String = ""
    var venue: String = ""
    var likes: Int = 0
    var dislikes: Int = 0
    var image: String = ""
    var desc: String = ""
    
    let Rating_Type_Format = "RATING_TYPE_"
    
   
    override init() {
        super.init()
    }
    
    init (_ item: JSON) {
        id = item["id"].intValue
        name = item["name"].stringValue
        artist = item["artist"].stringValue
        venue = item["venue"].stringValue
        likes = item["likes"].intValue
        dislikes = item["dislikes"].intValue
        image = "\(BaseUrl)/images/\(item["image"].stringValue)"
        desc = item["description"].stringValue
    }
    
    func setRatingType(_ type: RatingType) {
        switch type {
        case .none:
            UserDefaults.standard.set(0, forKey: "\(Rating_Type_Format)\(String(id))")
            break
        case .like:
            UserDefaults.standard.set(1, forKey: "\(Rating_Type_Format)\(String(id))")
            break
        case .dislike:
            UserDefaults.standard.set(2, forKey: "\(Rating_Type_Format)\(String(id))")
            break
        }
    }
    
    func getRatingType() -> RatingType {
        let type = UserDefaults.standard.integer(forKey: "\(Rating_Type_Format)\(String(id))")
        switch type {
        case 0:
            return .none
        case 1:
            return .like
        case 2:
            return .dislike
        default:
            return .none
        }
    }
}
