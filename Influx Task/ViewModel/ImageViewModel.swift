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

    var imageDetailsArr = [ImageDetails]()
    
    var idelegate : ImageViewModelDelegate?
    
    func getData(){
        APIService.shared.getResponse(responseType: [ResponseModel].self) { (result) in
            switch result {
            case .success(let data):
                for info in data {
                    self.imageDetailsArr.append(ImageDetails(name: info.author, width: info.width, height: info.height, details: info.url, downloadurl: info.download_url, type: .real))
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

    func cellForRow(indexPath: IndexPath) -> ImageDetails{
        return imageDetailsArr[indexPath.row]
    }
}
