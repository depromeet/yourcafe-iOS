//
//  OptionCollectionViewCell.swift
//  YourCafe
//
//  Created by 이동건 on 20/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageContainerView()
    }
    
    func configure(_ filter: FilterItem) {
        imageView.image = filter.optionIcon
        optionLabel.text = filter.optionTitle
    }
    
    private func setupImageContainerView() {
        imageContainerView.layer.cornerRadius = 10
        imageContainerView.layer.masksToBounds = true
        imageContainerView.layer.borderWidth = 1
        imageContainerView.layer.borderColor = UIColor.greyish.cgColor
    }
}
