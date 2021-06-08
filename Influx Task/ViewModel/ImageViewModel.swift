//
//  ImageViewModel.swift
//  Influx Task
//
//  Created by vinumax on 07/06/21.
//

import Foundation

protocol ImageViewModelDelegate : NSObject {
    func isResponseSuccess()
}

class ImageViewModel: NSObject {

    var imageDetailsArr = [FlickrInfo]()
    
    var idelegate : ImageViewModelDelegate?
    
    func getData(){
        APIService().getResponse("/services/feeds/photos_public.gne", responseType: [FlickrMedia].self) { (result) in
            switch result {
            case .success(let data):
                for info in data {
                    self.imageDetailsArr.append(FlickrInfo(title: info.title, link: info.link, media: info.media, description: info.description, tags: info.tags, type: .real))
                }
                self.idelegate?.isResponseSuccess()
            case .failure(_):
                print("error")
            }
        }
    }
    
    func numberOfRow(section:Int) -> Int{
        return imageDetailsArr.count
    }

    func cellForRow(indexPath: IndexPath) -> FlickrInfo{
        return imageDetailsArr[indexPath.row]
    }
}
