//
//  FringeEventDetailController.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//

import UIKit
import Kingfisher
import MBProgressHUD
import SwiftyJSON

protocol FringeEventDetailDelegate {
    func updateEvent(_ item: FringeEventItem)
}

class FringeEventDetailController: BaseViewController {
    
    @IBOutlet weak var img_event: UIImageView!
    @IBOutlet weak var btn_like: UIButton!
    @IBOutlet weak var lbl_like_count: UILabel!
    @IBOutlet weak var btn_dislike: UIButton!
    @IBOutlet weak var lbl_dislike_count: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_artist: UILabel!
    @IBOutlet weak var lbl_venue: UILabel!
    @IBOutlet weak var lbl_desc: UILabel!
    
    var data: FringeEventItem?
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onActionLike(_ sender: Any) {
        if data?.getRatingType() == RatingType.none {
            doRating("like")
        } else {
            self.showToastMessage(message: "You already rated this event")
        }
    }
    
    @IBAction func onActionDisLike(_ sender: Any) {
        if data?.getRatingType() == RatingType.none {
            doRating("dislike")
        } else {
            self.showToastMessage(message: "You already rated this event")
        }
    }
    
    func doRating(_ type: String) {
        if !isConnectedNetwork() {
            showNetConnectionAlert()
            return
        }
        
        let url_str = String(format: FringeEventRatingUrl, type, data?.id ?? 0)
        guard let url = URL(string: url_str) else {
            self.showToastMessage(message: STR_URL_PASSING_ERROR)
            return
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        getRequest(url: url, headers: nil) { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            let result = response["result"].stringValue.lowercased()
            if result == "success" {
                self.data?.likes = response["likes"].intValue
                self.data?.dislikes = response["dislikes"].intValue
                if type == "like" {
                    self.data?.setRatingType(.like)
                } else {
                    self.data?.setRatingType(.dislike)
                }
                self.setRating()
                guard let item = self.data else { return }
                self.delegate?.updateEvent(item)
            } else {
                let message = response["message"].stringValue
                self.showToastMessage(message: message)
            }
        }
    }
    
    func setRating() {
        let rating_type = data?.getRatingType() ?? .none
        switch rating_type {
        case .like:
            btn_like.setImage(img_like_active, for: .normal)
            btn_dislike.setImage(img_dislike, for: .normal)
            break
        case .dislike:
            btn_like.setImage(img_like, for: .normal)
            btn_dislike.setImage(img_dislike_active, for: .normal)
            break
        case .none:
            btn_like.setImage(img_like, for: .normal)
            btn_dislike.setImage(img_dislike, for: .normal)
            break
        }
        
        lbl_like_count.text = String(data?.likes ?? 0)
        lbl_dislike_count.text = String(data?.dislikes ?? 0)
    }
    
    var img_like: UIImage?
    var img_like_active: UIImage?
    var img_dislike: UIImage?
    var img_dislike_active: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        img_like = UIImage(systemName: "hand.thumbsup")
        img_like_active = UIImage(systemName: "hand.thumbsup.fill")
        img_dislike = UIImage(systemName: "hand.thumbsdown")
        img_dislike_active = UIImage(systemName: "hand.thumbsdown.fill")
        
        setData()
    }
    
    var delegate: FringeEventDetailDelegate?
    
    func setData() {
        img_event.kf.setImage(with: URL(string: data?.image ?? ""))
        lbl_name.text = data?.name
        lbl_artist.text = data?.artist
        lbl_venue.text = data?.venue
        lbl_desc.text = data?.desc
        
        setRating()
    }
}
