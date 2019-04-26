//
//  NSObject + reuseIdentifier.swift
//  YourCafe
//
//  Created by 이동건 on 20/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import Foundation

extension NSObject {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
