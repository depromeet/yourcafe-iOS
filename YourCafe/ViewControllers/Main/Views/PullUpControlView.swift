//
//  PullUpSearchControlView.swift
//  YourCafe
//
//  Created by 이동건 on 06/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

protocol PullUpControlViewDelegate: class {
    func pullUpControlView(_ pullUpSearchControlView: PullUpControlView, didPanned height: CGFloat)
}

protocol PullUpControlViewDataSource: class {
    func heightOfContainerView(_ pullUpControlView: PullUpControlView) -> CGFloat
    func heightOfSearchControlView(_ pullUpControlView: PullUpControlView) -> CGFloat
}

class PullUpControlView: UIView, NibInstantiable {
    private var panInitialHeight: CGFloat?
    
    var delegate: PullUpControlViewDelegate?
    var dataSource: PullUpControlViewDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        setupPanGesture()
    }
    
    private func setupView() {
        clipsToBounds = true
        layer.cornerRadius = 20
    }
    
    private func setupPanGesture() {
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let dataSource = dataSource else { return }
        let panCurrentHeight = panInitialHeight ?? dataSource.heightOfSearchControlView(self)
        
        switch gesture.state {
        case .changed:
            calculateHeight(panCurrentHeight, with: gesture)
        case .ended:
            panInitialHeight = frame.height
        default: return
        }
    }
    
    private func calculateHeight(_ panCurrentHeight: CGFloat, with gesture: UIPanGestureRecognizer) {
        guard let dataSource = dataSource else { return }
        let containerViewHeight = dataSource.heightOfContainerView(self)
        
        let yTranslation = (gesture.translation(in: self).y) * -1
        let yOffset = containerViewHeight - (panCurrentHeight + yTranslation)
        delegate?.pullUpControlView(self, didPanned: containerViewHeight - yOffset)
    }
}
