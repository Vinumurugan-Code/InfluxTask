
//
//  ImageDetails.swift
//  Influx Task
//
//  Created by vinumax on 07/06/21.
//

import UIKit

struct ResponseModel : Codable {
    var id: String
    var author : String
    var width : Int
    var height : Int
    var url : String
    var download_url : String
}

struct ImageDetails {
    var name: String
    var width : Int
    var height : Int
    var details : String
    var downloadurl : String
    var type: ImageType
}

enum ImageType: Int {
    case real
    case dummy
}


