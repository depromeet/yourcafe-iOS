//
//  PullUpSearchControlView.swift
//  YourCafe
//
//  Created by 이동건 on 06/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

protocol PullUpControlViewDelegate: class {
    func pullUpControlView(_ pullUpSearchControlView: PullUpControlView, didPanned height: CGFloat, animated: Bool)
}

protocol PullUpControlViewDataSource: class {
    func heightOfContainerView(_ pullUpControlView: PullUpControlView) -> CGFloat
    func minimumHeightOfPullUpControlView(_ pullUpControlView: PullUpControlView) -> CGFloat
    func maximumHeightOfPullUpControlView(_ pullUpControlView: PullUpControlView) -> CGFloat
}

class PullUpControlView: UIView, NibInstantiable {
    // MARK:- Nested Types
    enum Control {
        case pullUp
        case pullDown
    }
    
    struct UIMatrix {
        static let cornerRadius: CGFloat = 20
        static let indicatorViewCornerRadius: CGFloat = 3.5
        static let panGestureThreshold: CGFloat = 50
        static let cornerRadiusBottomSafeArea: CGFloat = 20
    }
    
    // MARK:- Outlets
    @IBOutlet weak var pullUpIndicatorView: UIView!
    
    // MARK:- Properties
    private var panInitialHeight: CGFloat?
    private var maximumHeight: CGFloat = 0
    private var minimumHeight: CGFloat = 0
    
    var delegate: PullUpControlViewDelegate?
    var dataSource: PullUpControlViewDataSource? {
        didSet {
            maximumHeight = dataSource?.maximumHeightOfPullUpControlView(self) ?? 0
            minimumHeight = dataSource?.minimumHeightOfPullUpControlView(self) ?? 0
        }
    }
    
    // MARK:- Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setupPanGesture()
    }
    
    // MARK:- Setup
    private func setupView() {
        setupContentView()
        setupPullUpIndicatorView()
    }
    
    private func setupContentView() {
        layer.masksToBounds = true
        layer.cornerRadius = 20 
    }
    
    private func setupPullUpIndicatorView() {
        pullUpIndicatorView.layer.cornerRadius = PullUpControlView.UIMatrix.indicatorViewCornerRadius
        pullUpIndicatorView.layer.masksToBounds = true
    }
    
    private func setupPanGesture() {
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    // MARK:- Action
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let dataSource = dataSource else { return }
        let panCurrentHeight = panInitialHeight ?? dataSource.minimumHeightOfPullUpControlView(self)
        
        switch gesture.state {
        case .changed:
            calculateHeight(panCurrentHeight, with: gesture)
        case .ended:
            animate(with: gesture)
        default: return
        }
    }
}

// MARK:- Handle PanGesture
extension PullUpControlView {
    private func calculateHeight(_ panCurrentHeight: CGFloat, with gesture: UIPanGestureRecognizer) {
        guard let dataSource = dataSource else { return }
        let containerViewHeight = dataSource.heightOfContainerView(self)
        
        let yTranslation = (gesture.translation(in: self).y) * -1
        let yOffset = containerViewHeight - (panCurrentHeight + yTranslation)
        let height = containerViewHeight - yOffset
        
        if isValidHeight(height) {
            delegate?.pullUpControlView(self, didPanned: height, animated: false)
        }
    }

    private func isValidHeight(_ height: CGFloat) -> Bool {
        return height <= maximumHeight && height >= minimumHeight
    }
    
    private func animate(with gesture: UIPanGestureRecognizer) {
        let control: Control = gesture.translation(in: self).y < 0 ? .pullUp : .pullDown
        let threshold = PullUpControlView.UIMatrix.panGestureThreshold
        let height = frame.height
        
        var targetHeight: CGFloat = 0
        switch control {
        case .pullUp:
            targetHeight = height >= minimumHeight + threshold ? maximumHeight : minimumHeight
        case .pullDown:
            targetHeight = height <= maximumHeight - threshold  ? minimumHeight : maximumHeight
        }
        adjustHeight(to: targetHeight, animated: true)
    }
    
    private func adjustHeight(to targetHeight: CGFloat, animated: Bool) {
        delegate?.pullUpControlView(self, didPanned: targetHeight, animated: animated)
        panInitialHeight = targetHeight
    }
}
