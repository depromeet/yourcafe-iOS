//
//  UIView + cornerRadius.swift
//  YourCafe
//
//  Created by 이동건 on 18/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

extension UIView {
    func makeCornerRounded(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
