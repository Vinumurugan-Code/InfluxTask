
//
//  ImageCollectionViewCell.swift
//  Influx Task
//
//  Created by vinumax on 07/06/21.
//


import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var mainBgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 5
        self.clipsToBounds = true
        // Initialization code
    }

}
