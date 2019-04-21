//
//  MenuSlideTransition.swift
//  YourCafe
//
//  Created by 이동건 on 21/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class MenuSlideTransition: NSObject {
    enum TransitionType {
        case present
        case hide
    }
    
    private var finalWidth: CGFloat
    private var finalHeight: CGFloat
    
    var transitionType: TransitionType = .present
    let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    init(finalWidth: CGFloat, finalHeight: CGFloat) {
        self.finalWidth = finalWidth
        self.finalHeight = finalHeight
        super.init()
    }
}

// MARK:- UIViewControllerAnimatedTransitioning

extension MenuSlideTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        let targetViewController = transitionType == .present ? toVC : fromVC
        
        if transitionType == .present {
            setupContainerView(of: transitionContext)
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancel = transitionContext.transitionWasCancelled
        
        UIView.animate(withDuration: duration, animations: {
            self.transform(type: self.transitionType, to: targetViewController)
        }) { (_) in
            transitionContext.completeTransition(!isCancel)
        }
    }
    
    private func setupContainerView(of transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        
        containerView.addSubview(dimmingView)
        dimmingView.frame = containerView.bounds
        containerView.addSubview(toVC.view)
        toVC.view.frame = CGRect(x: -finalWidth, y: 0, width: finalWidth, height: finalHeight)
    }
    
    private func transform(type: TransitionType, to targetViewController: UIViewController) {
        dimmingView.alpha = type == .present ? 0.5 : 0.0
        targetViewController.view.transform = type == .present ? CGAffineTransform(translationX: finalWidth, y: 0) : .identity
    }
}
