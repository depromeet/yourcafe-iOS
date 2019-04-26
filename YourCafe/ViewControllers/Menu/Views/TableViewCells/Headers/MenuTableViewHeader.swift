//
//  MenuTableViewHeader.swift
//  YourCafe
//
//  Created by 이동건 on 21/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class MenuTableViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var paddingView: UIView! {
        didSet {
            paddingView.backgroundColor = UIColor.dark
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setProfileImageViewRounded()
        contentView.backgroundColor = .white
    }
    
    private func setProfileImageViewRounded() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
    }
}
