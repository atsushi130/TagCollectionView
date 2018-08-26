//
//  TagCollectionView.swift
//  TagCollectionView
//
//  Created by Atsushi Miyake on 2018/08/26.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import SwiftExtensions

@IBDesignable
final class TagCollectionView: UIView, NibDesignable {
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.collectionViewLayout = self.layout
            self.collectionView.delegate   = self
            self.collectionView.dataSource = self
            self.collectionView.ex.register(cellType: TagCell.self)
        }
    }
    
    private lazy var layout: TagCollectionLayout = {
        let layout = TagCollectionLayout()
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        return layout
    }()
    
    let items = ["GUCCHI", "LOUIS VUITTON", "FENDI", "BALENCIAGA", "CELINE", "PRADA", "BURBERRY", "DOLCE&GABBANA"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureNib()
    }
}

extension TagCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.ex.dequeueReusableCell(with: TagCell.self, for: indexPath)
        cell.titleLabel.text = self.items[indexPath.row]
        return cell
    }
}

extension TagCollectionView: UICollectionViewDelegate {}
