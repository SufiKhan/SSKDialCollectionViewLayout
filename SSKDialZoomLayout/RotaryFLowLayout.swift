//
//  RotaryFLowLayout.swift
//  CollectionView
//
//  Created by mac on 30/03/17.
//  Copyright © 2017 mac. All rights reserved.
//

import UIKit

class RotaryFLowLayout: UICollectionViewFlowLayout {
    static let ROWHEIGHT = CGFloat(90)
    static let ZOOMSCALE = CGFloat(0.1)
    static let Y_FOR_SMALL_CELLS = CGFloat(30)
    static let Y_FOR_BIG_CELLS = CGFloat(5)
    static let ZOOM_FACTOR_FOR_SMALL_CELLS = CGFloat(0.8)
    static let ONE = CGFloat(1)
    var needsZoom = false
    var needsDial = false
    var currentIndex : Int?
    open var minimumScaleFactor: CGFloat = 0.7
    override init() {
        super.init()
        self.scrollDirection = .horizontal
        
    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let cvBounds = collectionView?.bounds
        let halfWidth = (cvBounds?.size.width)! * 0.5
        let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth
        if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds!) as [UICollectionViewLayoutAttributes]! {
            var candidateAttributes: UICollectionViewLayoutAttributes?
            for attributes in attributesForVisibleCells {
                // == Skip comparison with non-cell items (headers and footers) == //
                if attributes.representedElementCategory != UICollectionElementCategory.cell {
                    continue
                }
                if let candAttrs = candidateAttributes {
                    let a = attributes.center.x - proposedContentOffsetCenterX
                    let b = candAttrs.center.x - proposedContentOffsetCenterX
                    if fabsf(Float(a)) < fabsf(Float(b)) {
                        candidateAttributes = attributes
                    }else{
                        let newOffsetX = candidateAttributes!.center.x - self.collectionView!.bounds.size.width / 2
                        let offset = newOffsetX - self.collectionView!.contentOffset.x
                        if (velocity.x < 0 && offset > 0) || (velocity.x > 0 && offset < 0) {
                            candidateAttributes = attributes
                        }
                        
                        
                    }
                } else { // == First time in the loop == //
                    candidateAttributes = attributes
                    continue
                }
                
            }
            currentIndex = (candidateAttributes?.indexPath.row)!
            return CGPoint(x : candidateAttributes!.center.x - halfWidth, y : proposedContentOffset.y)
        }
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
   
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if(!needsZoom){
            return super.layoutAttributesForElements(in: rect)
        }else{
            let array = super.layoutAttributesForElements(in: rect)
            var visibleRect = CGRect()
            visibleRect.origin = (collectionView?.contentOffset)!
            visibleRect.size = (collectionView?.bounds.size)!
            let visibleCenterX = visibleRect.midX
            var newAttributesArray = Array<UICollectionViewLayoutAttributes>()
            for (_, attributes) in array!.enumerated() {
                let newAttributes = attributes.copy() as! UICollectionViewLayoutAttributes
                newAttributesArray.append(newAttributes)
                let distanceFromCenter = visibleCenterX - newAttributes.center.x
                let absDistanceFromCenter = min(abs(distanceFromCenter), attributes.frame.size.height)
                let scale = absDistanceFromCenter * (minimumScaleFactor - 1) / attributes.frame.size.height + 1
                if(needsDial){
                    if(scale < 1){
                        var mFrame = newAttributes.frame
                        mFrame.origin.y = (scale * 0.5) * abs(distanceFromCenter)
                        newAttributes.frame = mFrame
                        newAttributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
                        
                    }else{
                        var mFrame = newAttributes.frame
                        mFrame.origin.y = scale * abs(distanceFromCenter)
                        newAttributes.frame = mFrame
                        newAttributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
                    }
                }else{
                    newAttributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
                }
                
            }
            return newAttributesArray
        }
    }
    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
