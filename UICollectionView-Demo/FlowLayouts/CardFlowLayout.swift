//
//  CardFlowLayout.swift
//  UICollectionView-Demo
//
//  Created by Alan Liu on 2021/12/02.
//

import UIKit

class CardFlowLayout: UICollectionViewFlowLayout {
    /*
    // Method 1
    private let screenWidth = UIScreen.main.bounds.width
    private let cellWidth = UIScreen.main.bounds.width * 0.8
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var offsetAdjustment = CGFloat(MAXFLOAT)
        let horizontalOffset = proposedContentOffset.x + (screenWidth - cellWidth)/2
        
        guard let collectionView = collectionView else {
            return proposedContentOffset
        }
        
        let targetRect = CGRect(x: proposedContentOffset.x,
                                y: 0,
                                width: collectionView.bounds.width,
                                height: collectionView.bounds.height)
        
        guard let attributesList = super.layoutAttributesForElements(in: targetRect) else {
            return proposedContentOffset
        }
        
        for attributes in attributesList {
            let itemOffset = attributes.frame.origin.x
            
            if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }*/
    
    // Method 2
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        if let collectionViewBounds = self.collectionView?.bounds {
            let halfWidthOfVC = collectionViewBounds.size.width * 0.5
            let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidthOfVC
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: collectionViewBounds) {
                var candidateAttribute : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    if let candAttr = candidateAttribute {
                        let a = attributes.center.x - proposedContentOffsetCenterX
                        let b = candAttr.center.x - proposedContentOffsetCenterX
                        if abs(a) < abs(b) {
                            candidateAttribute = attributes
                        }
                    } else {
                        candidateAttribute = attributes
                        continue
                    }
                }
                if let candidateAttribute = candidateAttribute {
                    return CGPoint(x: candidateAttribute.center.x - halfWidthOfVC, y: proposedContentOffset.y)
                }
            }
        }
        return CGPoint.zero
    }
}
