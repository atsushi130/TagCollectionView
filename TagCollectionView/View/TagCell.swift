//
//  TagCell.swift
//  TagCollectionView
//
//  Created by Atsushi Miyake on 2018/08/26.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit
import SwiftExtensions

final class TagCell: UICollectionViewCell, NibInstantiatable {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.preferredMaxLayoutWidth = 375
        self.layer.cornerRadius = 19.0
        self.layer.borderColor  = UIColor.ex.hex(string: "#FFCF07").cgColor
        self.layer.borderWidth  = 1.0
    }
}
