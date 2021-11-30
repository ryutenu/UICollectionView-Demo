//
//  CardCell.swift
//  UICollectionView-Demo
//
//  Created by Alan Liu on 2021/11/30.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private let colors = [UIColor.systemBlue, UIColor.systemGreen, UIColor.systemOrange, UIColor.systemPink]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(index: Int) {
        if colors.indices.contains(index) {
            bgView.backgroundColor = colors[index]
        }
        titleLabel.text = "Card" + String(index)
    }
}
