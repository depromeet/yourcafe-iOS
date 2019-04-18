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
    
    private var pullUpControlView: PullUpControlView? = PullUpControlView.instantiateFromNib()
    private var pullUpControlViewHeightConstraint: NSLayoutConstraint?
    
    private var pullUpControlViewHeight: CGFloat = 59
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        setPullUpControlView()
    }
    
    private func setupMapView() {
        naverMapView.mapView.zoomLevel = 15
        naverMapView.showLocationButton = true
        naverMapView.showZoomControls = false
        naverMapView.showCompass = false
    }
    
    private func setPullUpControlView() {
        guard let controlView = pullUpControlView else { return }
        controlView.delegate = self
        controlView.dataSource = self
        
        layoutPullUpControlView()
    }
    
    private func layoutPullUpControlView() {
        guard let controlView = pullUpControlView else { return }
        controlView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controlView)
        
        controlView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        controlView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        controlView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        pullUpControlViewHeightConstraint = controlView.heightAnchor.constraint(equalToConstant: pullUpControlViewHeight)
        pullUpControlViewHeightConstraint?.isActive = true
    }
}

extension MapViewController: PullUpControlViewDataSource {
    func heightOfContainerView(_ pullUpSearchControlView: PullUpControlView) -> CGFloat {
        return view.frame.height
    }
    
    func minimumHeightOfPullUpControlView(_ pullUpSearchControlView: PullUpControlView) -> CGFloat {
        return pullUpControlViewHeight
    }
    
    func maximumHeightOfPullUpControlView(_ pullUpControlView: PullUpControlView) -> CGFloat {
        return 400
    }
}

extension MapViewController: PullUpControlViewDelegate {
    func pullUpControlView(_ pullUpControlView: PullUpControlView, didPanned height: CGFloat, animated: Bool) {
        pullUpControlViewHeightConstraint?.constant = height
        
        if animated {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
