//
//  TagCollectionLayout.swift
//  TagCollectionView
//
//  Created by Atsushi Miyake on 2018/08/26.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

final class TagCollectionLayout: UICollectionViewFlowLayout {
    
    var flowLayoutDelegate: UICollectionViewDelegateFlowLayout? {
        return self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return super.layoutAttributesForElements(in: rect)?
            .enumerated()
            .filter { index, attribute in
                attribute.representedElementCategory == .cell
            }
            .map { index, attribute in
                layoutAttributesForItem(at: attribute.indexPath) ?? UICollectionViewLayoutAttributes()
            }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let currentAttributes = super.layoutAttributesForItem(at: indexPath),
              let viewWidth = self.collectionView?.frame.width else { return nil }
        let sectionInsetsLeft = self.sectionInsets(at: indexPath.section).left
        
        // 先頭のセルは sectionInsets.left
        guard indexPath.item > 0 else {
            currentAttributes.frame.origin.x = sectionInsetsLeft
            return currentAttributes
        }
        
        // Frame 取得
        guard let frame: (prev: CGRect, current: CGRect) = {
            let indexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
            guard let prevFrame = layoutAttributesForItem(at: indexPath)?.frame else { return nil }
            let currentFrame = currentAttributes.frame
            return (prev: prevFrame, current: currentFrame)
        }() else { return nil }

        // 現在の行に収まらなければ sectionInset.left
        let validWidth = viewWidth - self.sectionInset.left - self.sectionInset.right
        let currentColumnRect = CGRect(x: sectionInsetsLeft, y: frame.current.origin.y, width: validWidth, height: frame.current.height)
        guard frame.prev.intersects(currentColumnRect) else {
            currentAttributes.frame.origin.x = sectionInsetsLeft
            return currentAttributes
        }
        
        // ひとつ前のセル + minimumInteritemSpacing を x 座標として返す
        currentAttributes.frame.origin.x = frame.prev.origin.x + frame.prev.width + self.minimumInteritemSpacing(at: indexPath.section)
        return currentAttributes
    }
    
    private func sectionInsets(at index: Int) -> UIEdgeInsets {
        guard let collectionView = self.collectionView else { return self.sectionInset }
        return self.flowLayoutDelegate?.collectionView?(collectionView, layout: self, insetForSectionAt: index) ?? self.sectionInset
    }
    
    private func minimumInteritemSpacing(at index: Int) -> CGFloat {
        guard let collectionView = collectionView else { return self.minimumInteritemSpacing }
        return self.flowLayoutDelegate?.collectionView?(collectionView,
                                                        layout: self,
                                                        minimumInteritemSpacingForSectionAt: index) ?? self.minimumInteritemSpacing
    }
}
