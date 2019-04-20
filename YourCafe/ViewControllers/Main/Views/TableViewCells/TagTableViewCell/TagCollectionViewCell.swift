//
//  TagCollectionViewCell.swift
//  YourCafe
//
//  Created by 이동건 on 20/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabelCotainerView()
    }
    
    func configure(_ tag: String) {
        tagLabel.text = tag
    }
    
    private func setupLabelCotainerView() {
        labelContainerView.layer.cornerRadius = 10
        labelContainerView.layer.masksToBounds = true
        labelContainerView.layer.borderWidth = 1
        labelContainerView.layer.borderColor = UIColor.greyish.cgColor
    }
}
