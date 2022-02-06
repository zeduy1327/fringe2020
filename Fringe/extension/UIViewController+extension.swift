//
//  UIViewController+extension.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
// 

import UIKit
import SwiftyJSON
import Toast_Swift
import MBProgressHUD

extension UIViewController {
    
    func showAlert(title: String, message: String, completion: @escaping ()->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
        
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithButton(title: String, message: String, ok: String, cancel: String, completion: @escaping ()->Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: ok, style: .default, handler: { (alert) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert_2(title: String, message: String, completion: @escaping ()->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showToastMessage(message: String) {
        var style = ToastStyle()
        style.messageColor = .white
        self.view.makeToast(message, duration: 3.0, position: .bottom, style: style)
    }
    
    func appDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
   
    func showNetConnectionAlert() {
        let title = "Whoops!"
        let message = "NetworkError: Please verify that you have internet connectivity"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
