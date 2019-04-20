//
//  CollecitonTableViewCell.swift
//  YourCafe
//
//  Created by 이동건 on 20/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

struct FilterItem {
    var optionIcon: UIImage
    var optionTitle: String
}

class OptionCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: DynamicHeightCollectionView!
    
    private var filterList: [FilterItem] = [
        FilterItem(optionIcon: #imageLiteral(resourceName: "iconFilteringReservation"), optionTitle: "주차장"),
        FilterItem(optionIcon: #imageLiteral(resourceName: "iconFilteringPower"), optionTitle: "흡연실"),
        FilterItem(optionIcon: #imageLiteral(resourceName: "iconFilteringReservation"), optionTitle: "주차장"),
        FilterItem(optionIcon: #imageLiteral(resourceName: "iconFilteringPower"), optionTitle: "남녀 분리화장실"),
        FilterItem(optionIcon: #imageLiteral(resourceName: "iconFilteringReservation"), optionTitle: "주차장"),
        FilterItem(optionIcon: #imageLiteral(resourceName: "iconFilteringPower"), optionTitle: "흡연실"),
        FilterItem(optionIcon: #imageLiteral(resourceName: "iconFilteringReservation"), optionTitle: "주차장"),
        FilterItem(optionIcon: #imageLiteral(resourceName: "iconFilteringPower"), optionTitle: "흡연실")
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCells()
        reload()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: OptionCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: OptionCollectionViewCell.reuseIdentifier)
    }
    
    private func reload() {
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension OptionCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 0, bottom: 72, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 65, height: 100)
    }
}

// MARK:- UICollectionViewDataSource

extension OptionCollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.reuseIdentifier, for: indexPath) as! OptionCollectionViewCell
        let option = filterList[indexPath.item]
        cell.configure(option)
        return cell
    }
}
