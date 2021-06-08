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
    
    func removeHTMLcontent() -> String {
        if !self.isEmpty {
            let myString = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            let newString = myString.replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression, range: nil)
            let lastString = newString.trimmingCharacters(in: .whitespacesAndNewlines)
            return lastString
        }
        return String.init()
    }
}

extension NSMutableAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let rect : CGRect = self.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        let requredSize:CGRect = rect
        return requredSize.height
    }
}
