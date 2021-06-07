
//
//  ViewController.swift
//  Influx Task
//
//  Created by vinumax on 07/06/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var imageVM = ImageViewModel()
        
    var currenIndexPath :IndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerCell()
        self.imageVM.idelegate = self
        self.imageVM.getData()
        // Do any additional setup after loading the view.
        let layout = CustomizeCVLayout()
        layout.delegate = self
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
        
}

extension ViewController: ImageViewModelDelegate {
    
    func isResponseSuccess() {
        self.collectionView.reloadData()
    }
    
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageVM.numberOfRow(section: section) 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let info = imageVM.cellForRow(indexPath:indexPath)
        if info.type == .real {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.self.description(), for: indexPath) as! ImageCollectionViewCell
            cell.mainImageView.sd_setImage(with: URL(string:info.downloadurl ), placeholderImage:nil)
            if indexPath == self.currenIndexPath {
                cell.layer.borderColor = UIColor.blue.cgColor
            } else {
                cell.layer.borderColor = UIColor.clear.cgColor
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.self.description(), for: indexPath) as! DetailsCollectionViewCell
            cell.detailsTxtV.text = "Name: " + info.name + "\n" + "URL: " + info.details + "\n" + "Width: \(info.width)" + "  "  + "Height: \(info.height)"
            if let index = self.currenIndexPath {
                cell.leftImage.isHidden = (index.row % 2) == 0
                cell.rightImage.isHidden = (index.row % 2) == 1
            } else {
                cell.leftImage.isHidden = true
                cell.rightImage.isHidden = true
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let info = imageVM.cellForRow(indexPath:indexPath)
        
        imageVM.imageDetailsArr.removeAll { (imageDetails) -> Bool in
            return imageDetails.type == .dummy
        }
        if info.type == .dummy || self.currenIndexPath?.row == indexPath.row {
            self.currenIndexPath = nil
            self.collectionView.reloadData()
            return // detail no need to have any thing
        }
        imageVM.imageDetailsArr.removeAll { (imageDetails) -> Bool in
            return imageDetails.type == .dummy
        }
        var copyImageDetails = info
        copyImageDetails.type = .dummy
        let indexValue = imageVM.imageDetailsArr.firstIndex { (imagedetails1) -> Bool in
            imagedetails1.name == info.name && imagedetails1.details == info.details && imagedetails1.type == info.type
        } ?? 0
        
        if indexValue % 2 == 0 {
            if indexValue + 2 < imageVM.imageDetailsArr.count {
                imageVM.imageDetailsArr.insert(copyImageDetails, at: indexValue + 2)
            } else {
                imageVM.imageDetailsArr.insert(copyImageDetails, at: indexValue + 1)
            }
        } else {
            imageVM.imageDetailsArr.insert(copyImageDetails, at: indexValue + 1)
        }
        self.currenIndexPath = IndexPath.init(row: indexValue, section: 0)
        self.collectionView.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension ViewController : CustomizeLayoutDelegate {
    func isDummyDeails(at indexPath: IndexPath) -> Bool {
        let info = imageVM.cellForRow(indexPath:indexPath)
        return info.type == .dummy
    }
    
    
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let info = imageVM.cellForRow(indexPath:indexPath)
        if info.type == .real {
            return CGSize(width: (collectionView.frame.width / 2) - 40, height: (collectionView.frame.width / 2) - 40)
        } else {
            let height = ("Name: " + info.name + "\n" + "URL: " + info.details + "\n" + "Width: \(info.width)" + "  " + "Height: \(info.height)").height(withConstrainedWidth: (collectionView.frame.width / 2) - 10, font: UIFont.systemFont(ofSize: 15))
            return CGSize(width: (collectionView.frame.width / 2) - 20, height: height + 40)
        }
    }    
}


