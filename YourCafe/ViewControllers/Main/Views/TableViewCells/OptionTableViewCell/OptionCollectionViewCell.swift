//
//  OptionCollectionViewCell.swift
//  YourCafe
//
//  Created by 이동건 on 20/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {
    struct UIMatrix {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 1
    }
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    
    private var filter: FilterItem?
    
    override var isSelected: Bool {
        didSet {
            handleCellSelection()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageContainerView()
    }
    
    func configure(_ filter: FilterItem) {
        self.filter = filter
        imageView.image = UIImage(named: filter.optionIconName)
        optionLabel.text = filter.optionTitle
    }
    
    private func handleCellSelection() {
        imageContainerView.backgroundColor = isSelected ? UIColor.orangeYellow : UIColor.white
        imageContainerView.layer.borderColor = isSelected ? UIColor.orangeYellow.cgColor : UIColor.greyish.cgColor
        imageView.image = isSelected ? UIImage(named: filter?.optionIconSelectedName ?? "") : UIImage(named: filter?.optionIconName ?? "")
        optionLabel.textColor = isSelected ? UIColor.dark : UIColor.greyish
    }
    
    private func setupImageContainerView() {
        imageContainerView.layer.cornerRadius = OptionCollectionViewCell.UIMatrix.cornerRadius
        imageContainerView.layer.masksToBounds = true
        imageContainerView.layer.borderWidth = OptionCollectionViewCell.UIMatrix.borderWidth
        imageContainerView.layer.borderColor = UIColor.greyish.cgColor
    }
}
