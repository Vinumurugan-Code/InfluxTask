//
//  Extension.swift
//  Influx Task
//
//  Created by vinumax on 07/06/21.
//

import UIKit

extension UICollectionView {
    func registerCell() {
        self.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.self.description())
        self.register(UINib.init(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DetailsCollectionViewCell.self.description())
    }
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
}

