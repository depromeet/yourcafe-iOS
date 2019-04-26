//
//  NibInstantiatable.swift
//  YourCafe
//
//  Created by 이동건 on 06/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

protocol NibInstantiable { }

extension NibInstantiable where Self: UIView {
    static func instantiateFromNib() -> Self? {
        let bundle = Bundle.main.loadNibNamed(String(describing: self), owner: self, options: nil)
        return bundle?.first as? Self
    }
}
