//
//  Network.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
// 

import Foundation
import Alamofire
import SwiftyJSON

let BaseUrl = "http://www.partiklezoo.com/fringer"
let FringeEventListUrl = "\(BaseUrl)/?"
let FringeEventRatingUrl = "\(BaseUrl)/?action=rate&rating=%@&id=%d"
let FringeEventInterestUrl = "\(BaseUrl)/?action=register&id=%d"
let VenuesUrl = "\(BaseUrl)/?action=venues"

func getRequest(url: URL, headers: HTTPHeaders?, completion: @escaping (JSON)->Void) {
    AF.request(url, method: .get, headers: headers).responseJSON { (response) in
        if let result = response.value {
            let jsonData = JSON(result)
            completion(jsonData)
        } else {
            completion(JSON([
                "res": "failed",
                "err_msg": "Connection failed.",
            ]))
        }
    }
}

func postRequest(url: URL, headers: HTTPHeaders?, params: Parameters, completion: @escaping (JSON)->Void) {
    AF.request(url, method: .post, parameters: params, headers: headers).responseJSON { (response) in
        if let result = response.value {
            let jsonData = JSON(result)
            completion(jsonData)
        } else {
            completion(JSON([
                "res": "failed",
                "err_msg": "Connection failed.",
            ]))
        }
    }
}

func isConnectedNetwork() -> Bool {
       return NetworkReachabilityManager()!.isReachable
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}
