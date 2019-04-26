//
//  MenuTableViewCell.swift
//  YourCafe
//
//  Created by 이동건 on 21/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.backgroundColor = UIColor.dark
    }
    
    func configure(_ title: String) {
        menuTitleLabel.text = title
    }
}
