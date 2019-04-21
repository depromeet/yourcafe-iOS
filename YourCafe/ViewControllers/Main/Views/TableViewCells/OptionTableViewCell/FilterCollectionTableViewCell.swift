//
//  CollecitonTableViewCell.swift
//  YourCafe
//
//  Created by 이동건 on 20/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class FilterCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: DynamicHeightCollectionView!
    
    private var filterList: [FilterItem] = FilterItem.bundles
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true 
        registerCells()
        reload()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: FilterCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.reuseIdentifier)
    }
    
    private func reload() {
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension FilterCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
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

extension FilterCollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseIdentifier, for: indexPath) as! FilterCollectionViewCell
        let option = filterList[indexPath.item]
        cell.configure(option)
        return cell
    }
}
