//
//  LeftAlignedBadgeFlowLayout.swift
//  IssueTracker
//
//  Created by 김신우 on 2020/11/09.
//  Copyright © 2020 IssueTracker-15. All rights reserved.
//

import UIKit

class LeftAlignedBadgeFlowLayout: UICollectionViewFlowLayout {
    
    var leftSpacing: CGFloat = 0
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributesForElementInRect = super.layoutAttributesForElements(in: rect)
        var newAttributesForElementsInRect = [UICollectionViewLayoutAttributes]()
        
        var leftMargin: CGFloat = 0
        for attributes in attributesForElementInRect! {
            
            if attributes.frame.origin.x == self.sectionInset.left {
                leftMargin = self.sectionInset.left
            } else {
                var newLeftAlignedFrame = attributes.frame
                newLeftAlignedFrame.origin.x = leftMargin
                attributes.frame = newLeftAlignedFrame
            }
            
            leftMargin += attributes.frame.size.width + leftSpacing
            newAttributesForElementsInRect.append(attributes)
        }
        return newAttributesForElementsInRect
    }
    
}
