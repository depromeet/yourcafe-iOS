//
//  MapViewController.swift
//  YourCafe
//
//  Created by 이동건 on 06/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
    }
    
    func setupMapView() {
        naverMapView.mapView.zoomLevel = 15
        naverMapView.showLocationButton = true
        naverMapView.showZoomControls = false
        naverMapView.showCompass = false
    }
}
