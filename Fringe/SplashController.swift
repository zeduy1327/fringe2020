//
//  SplashController.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
// 

import UIKit

class SplashController: UIViewController {

    @IBOutlet weak var img_title: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(img_title)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.appDelegate()?.gotoHomePage()
        }
    }

}

