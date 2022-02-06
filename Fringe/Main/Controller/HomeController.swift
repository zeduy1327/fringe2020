//
//  HomeController.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import UIKit

class HomeController: BaseViewController {
    
    @IBAction func onList(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FringeEventListController") as? FringeEventListController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onBrowse(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrowseFringeEventsController") as? BrowseFringeEventsController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onVenues(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "VenuesController") as? VenuesController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onAboutus(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutusController") as? AboutusController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onCopywrite(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CopywriteController") as? CopywriteController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}
