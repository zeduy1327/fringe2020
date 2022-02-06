//
//  FringeEventListController.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class FringeEventListController: BaseViewController, FringeEventDetailDelegate {
    
    func updateEvent(_ item: FringeEventItem) {
        self.eventModel.setItem(item)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var eventModel: FringeEventModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventModel = FringeEventModel()
        loadData()
    }
    
    func loadData() {
        if !isConnectedNetwork() {
            showNetConnectionAlert()
            return
        }
        
        let url_str = FringeEventListUrl
        guard let url = URL(string: url_str) else {
            self.showToastMessage(message: STR_URL_PASSING_ERROR)
            return
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        getRequest(url: url, headers: nil) { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.eventModel.setData(response)
            self.tableView.reloadData()
        }
    }
}

extension FringeEventListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FringeEventCell", for: indexPath) as! FringeEventCell
        cell.data = eventModel.getItemAt(indexPath.row)
        cell.setData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FringeEventDetailController") as? FringeEventDetailController {
            vc.data = eventModel.getItemAt(indexPath.row)
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
