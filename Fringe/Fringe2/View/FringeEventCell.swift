//
//  FringeEventCell.swift
//  Fringe
//
//  Created by Robin Hare on 11/7/20.
//  Copyright © 2020 Robin Hare. All rights reserved.
//

import UIKit
import Kingfisher

class FringeEventCell: UITableViewCell {
    
    @IBOutlet weak var img_event: UIImageView!
    @IBOutlet weak var lbl_desc: UILabel!
    
    var data: FringeEventItem?
    
    func setData() {
        img_event.kf.setImage(with: URL(string: data?.image ?? ""))
        lbl_desc.text = data?.desc
    }
}
