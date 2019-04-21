//
//  TagCollectionViewCell.swift
//  YourCafe
//
//  Created by 이동건 on 20/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    struct UIMatrix {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }
    
    @IBOutlet weak var labelContainerView: UIView!
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabelCotainerView()
        isSelected = false
    }
    
    override var isSelected: Bool {
        didSet {
            handleCellSelection()
        }
    }
    
    func configure(_ tag: String) {
        tagLabel.text = tag
    }

    private func handleCellSelection() {
        labelContainerView.backgroundColor = isSelected ? UIColor.orangeYellow : UIColor.white
        labelContainerView.layer.borderColor = isSelected ? UIColor.orangeYellow.cgColor : UIColor.greyish.cgColor
        tagLabel.textColor = isSelected ? UIColor.dark : UIColor.greyish
    }
    
    private func setupLabelCotainerView() {
        labelContainerView.layer.cornerRadius = TagCollectionViewCell.UIMatrix.cornerRadius
        labelContainerView.layer.masksToBounds = true
        labelContainerView.layer.borderWidth = TagCollectionViewCell.UIMatrix.borderWidth
        labelContainerView.layer.borderColor = UIColor.greyish.cgColor
    }
}
