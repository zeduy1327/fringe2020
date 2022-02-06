//
//  VenuesController.swift
//  Adelaide FringeTests
//
//  Created by Pham, Duy Anh - phady026 on 8/11/20.
//  Copyright © 2020 Pham, Duy Anh - phady026. All rights reserved.
//


import UIKit
import GoogleMaps
import MapKit
import CoreLocation
import SwiftyJSON
import MBProgressHUD
import SnapKit

class VenuesController: BaseViewController {
    
    @IBOutlet weak var mapContainer: UIView!
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var venuesModel: VenuesModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        venuesModel = VenuesModel()
        loadData()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func loadData() {
        if !isConnectedNetwork() {
            showNetConnectionAlert()
            return
        }
        
        let url_str = VenuesUrl
        guard let url = URL(string: url_str) else {
            self.showToastMessage(message: STR_URL_PASSING_ERROR)
            return
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        getRequest(url: url, headers: nil) { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.venuesModel.setData(response)
            self.venues_items = self.venuesModel.getItems()
            self.displayMarkers()
        }
    }
    
    var venues_items: [VenuesItem] = []
    
    func displayMarkers() {
        guard let first_item = venues_items.first else {
            return
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: first_item.latitude, longitude: first_item.longitude, zoom: default_zoom)
        if mapView != nil {
            mapView.animate(to: camera)
            
            venues_items.forEach { (item) in
                let marker = GMSMarker()
                marker.title = item.name
                marker.snippet = String(item.id)
    //            marker.icon = value.image
    //            marker.setIconSize(scaledToSize: .init(width: 25, height: 25))
                marker.position = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
                marker.map = self.mapView
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !is_mapview_loaded {
           
            if locationManager.location != nil {
                is_mapview_loaded = true
                cur_location = locationManager.location?.coordinate
                   
                let camera = GMSCameraPosition.camera(withLatitude: cur_location?.latitude ?? 0, longitude: cur_location?.longitude ?? 0, zoom: default_zoom)
                mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                mapContainer.addSubview(mapView)
                mapView.snp.makeConstraints { (make) in
                    make.top.leading.bottom.trailing.equalTo(mapContainer)
                }
//                mapView.delegate = self
                   
                mapView.isTrafficEnabled = false
                mapView.isMyLocationEnabled = true
            }
             
        }
    }
    
    var is_mapview_loaded = false
    let locationManager = CLLocationManager()
    var mapView: GMSMapView!
    var cur_location: CLLocationCoordinate2D?
    let default_zoom: Float = 15.0
  
}

extension VenuesController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if !is_mapview_loaded {
           
            if locationManager.location != nil {
                is_mapview_loaded = true
                cur_location = locationManager.location?.coordinate
                   
                let camera = GMSCameraPosition.camera(withLatitude: cur_location?.latitude ?? 0, longitude: cur_location?.longitude ?? 0, zoom: default_zoom)
                mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                mapContainer.addSubview(mapView)
                mapView.snp.makeConstraints { (make) in
                    make.top.leading.bottom.trailing.equalTo(mapContainer)
                }
//                mapView.delegate = self
                   
                mapView.isMyLocationEnabled = true
            }
             
        }
        
    }
}
