//
//  TagCollectionTableViewCell.swift
//  YourCafe
//
//  Created by 이동건 on 20/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

class TagCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: DynamicHeightCollectionView!
    
    private var tagList: [String] = [
        "센 와이파이",
        "왁자지껄한 편",
        "내부 공간이 복잡함",
        "내부가 추운 편",
        "내부가 더운 편",
        "남녀 분리 화장실",
        "예약 가능",
        "조용함",
        "주차장 있음",
        "콘센트 많음",
        "주차장 있음"
    ]

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = LeftAlignedCollectionViewFlowLayout.tagCollectionViewLayout
        registerCells()
        reload()
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: TagCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: TagCollectionViewCell.reuseIdentifier)
    }
    
    private func reload() {
        collectionView.reloadData()
        layoutIfNeeded()
    }
}

// MARK:- UICollectionViewDelegateFlowLayout

extension TagCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 0, bottom: 72, right: 0)
    }
}

// MARK:- UICollectionViewDataSource

extension TagCollectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.reuseIdentifier, for: indexPath) as! TagCollectionViewCell
        cell.configure(tagList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (self.tagList[indexPath.item] as NSString).size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)])
        return CGSize(width: size.width + 38.0, height: size.height + 25.0)
    }
}
