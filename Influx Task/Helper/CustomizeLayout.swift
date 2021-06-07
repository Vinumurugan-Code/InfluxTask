
//
//  CustomizeLayout.swift
//  Influx Task
//
//  Created by vinumax on 07/06/21.
//


import Foundation
import UIKit

class CustomizeCVLayout : UICollectionViewLayout {
    
    weak var delegate : CustomizeLayoutDelegate?
    
    private var cache : [UICollectionViewLayoutAttributes] = []
    
    private var contentWidth : CGFloat{
        guard let collectionView = collectionView else{
            return 0
        }
        let insets = collectionView.contentInset
        
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    private var contentHeight : CGFloat = 0
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 4
    
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth, height: contentHeight)
    }
}

extension CustomizeCVLayout{
    
    override func prepare() {
        
        guard let collectionView = collectionView else{
            return
        }
        
        cache.removeAll()
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            let itemSize = delegate?.collectionView(collectionView, getSizeAtIndexPath: indexPath) ?? CGSize(width: 40, height: 40)
            let height = cellPadding * 2 + itemSize.height
            var frame = CGRect(x: xOffset[column],
                               y: yOffset[column],
                               width: columnWidth,
                               height: height)
            var value = 0
            if let ishaveImage = delegate?.isDummyDeails(at: indexPath), ishaveImage {
                frame = CGRect(x: 0,
                               y: yOffset[0] >= yOffset[1] ? yOffset[0]:yOffset[1],
                               width: contentWidth,
                               height: height)
                value = yOffset[0] >= yOffset[1] ? 0:1
                column = 1
            }
            
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            attributes.frame = insetFrame
            
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            
            if let ishaveImage = delegate?.isDummyDeails(at: indexPath), ishaveImage {
                let value = yOffset[0] >= yOffset[1] ? yOffset[0]:yOffset[1]
                yOffset[0] = value + height
                yOffset[1] = value + height
            } else {
                yOffset[column] = yOffset[column] + height
            }
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
protocol CustomizeLayoutDelegate : class {
    func collectionView(_ collectionView : UICollectionView, getSizeAtIndexPath indexPath : IndexPath)->CGSize
    func isDummyDeails(at indexPath: IndexPath) -> Bool
    
}
