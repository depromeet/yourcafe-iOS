//
//  MapViewController.swift
//  YourCafe
//
//  Created by 이동건 on 06/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit
import NMapsMap

class NaverMapViewManager: NSObject {
    private var locationManager = CLLocationManager()
    private var naverMapView: NMFNaverMapView
    
    init(naverMapView: NMFNaverMapView) {
        self.naverMapView = naverMapView
        super.init()
        locationManager.delegate = self
        moveMapCameraToCurrentLocation()
    }
    
    private func moveMapCameraToCurrentLocation() {
        guard let currentCoordinate = locationManager.location?.coordinate else { return }
        naverMapView.mapView.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(from: currentCoordinate)))
    }
}

extension NaverMapViewManager: CLLocationManagerDelegate {
    
}

class MapViewController: UIViewController {
    // MARK:- Outlets
    @IBOutlet weak var bluerEffectView: UIVisualEffectView!
    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var slideMenuButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var naverMapView: NMFNaverMapView!
    
    private var pullUpControlView: PullUpControlView?
    private var pullUpControlViewHeightConstraint: NSLayoutConstraint?
    
    // MARK:- Constraints
    private var pullUpControlViewHeight: CGFloat = 79 + PullUpControlView.UIMatrix.cornerRadiusBottomSafeArea
    private var pullUpControlViewMaximumHeightOffset: CGFloat = 96
    
    private var mapViewManager: NaverMapViewManager?
    private var slideTransition: MenuSlideTransition?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupMapViewManager()
        slideTransition = MenuSlideTransition(finalWidth: 280, finalHeight: view.frame.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard pullUpControlView == nil else { return }
        pullUpControlView = PullUpControlView.instantiateFromNib()
        setPullUpControlView()
    }

    // MARK:- Setup
    
    private func setupMapViewManager() {
        mapViewManager = NaverMapViewManager(naverMapView: naverMapView)
    }
    
    // MARK:- Handle Slide Menu
    
    @IBAction func handleSlideMenuButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: MenuViewController.reuseIdentifier, bundle: nil)
        let menuViewController = storyboard.instantiateViewController(withIdentifier: MenuViewController.reuseIdentifier)
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true, completion: nil)
    }
}

// MARK:- UIViewControllerTransitioningDelegate

extension MapViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideTransition?.transitionType = .present
        slideTransition?.dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMenuViewDismiss)))
        return slideTransition
    }
    
    @objc func handleMenuViewDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        slideTransition?.transitionType = .hide
        return slideTransition
    }
}

// MARK:- UITextFieldDelegate

extension MapViewController: UITextFieldDelegate {
    private func handleKeyboardHide() {
        bluerEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBlurViewTap)))
        searchTextField.delegate = self
    }
    
    @objc func handleBlurViewTap() {
        bluerEffectView.isHidden = true
        searchTextField.text = ""
        view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        bluerEffectView.isHidden = false
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bluerEffectView.isHidden = true
        view.endEditing(true)
        return true
    }
}

// MARK:- Setup & Layout Views

extension MapViewController {
    private func setupViews() {
        setupMapView()
        setupSearchContainerView()
        handleKeyboardHide()
    }
    
    private func setupMapView() {
        naverMapView.mapView.zoomLevel = 15
        naverMapView.showLocationButton = true
        naverMapView.showZoomControls = false
        naverMapView.showCompass = false
        naverMapView.showLocationButton = false
        naverMapView.showScaleBar = false
        naverMapView.mapView.logoAlign = .leftTop
    }
    
    private func setupSearchContainerView() {
        searchContainerView.layer.cornerRadius = 10
        searchContainerView.layer.masksToBounds = true
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
        
        controlView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13).isActive = true
        controlView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13).isActive = true
        controlView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: PullUpControlView.UIMatrix.cornerRadiusBottomSafeArea).isActive = true
        pullUpControlViewHeightConstraint = controlView.heightAnchor.constraint(equalToConstant: pullUpControlViewHeight)
        pullUpControlViewHeightConstraint?.isActive = true
    }
}

// MARK:- PullUpControlViewDataSource

extension MapViewController: PullUpControlViewDataSource {
    func heightOfContainerView(_ pullUpSearchControlView: PullUpControlView) -> CGFloat {
        return view.frame.height
    }
    
    func minimumHeightOfPullUpControlView(_ pullUpSearchControlView: PullUpControlView) -> CGFloat {
        return pullUpControlViewHeight
    }
    
    func maximumHeightOfPullUpControlView(_ pullUpControlView: PullUpControlView) -> CGFloat {
        let searchContainerViewHeight = searchContainerView.frame.height
        let serachContainerViewMiY = searchContainerView.frame.minY
        return view.frame.height - (searchContainerViewHeight + serachContainerViewMiY) + PullUpControlView.UIMatrix.cornerRadiusBottomSafeArea
    }
}

// MARK:- PullUpControlViewDelegate

extension MapViewController: PullUpControlViewDelegate {
    func pullUpControlView(_ pullUpControlView: PullUpControlView, didPanned height: CGFloat, animated: Bool) {
        pullUpControlViewHeightConstraint?.constant = height
        
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.bluerEffectView.isHidden = !self.bluerEffectView.isHidden
                self.searchContainerView.alpha = height == self.pullUpControlViewHeight ? 1 : 0
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
