
//
//  ImageDetails.swift
//  Influx Task
//
//  Created by vinumax on 07/06/21.
//

import UIKit

struct FlickrMedia: Codable {
    let title: String
    let link: String
    let media: [String:String]
    let description: String
    let tags: String?
}

struct FlickrInfo {
    let title: String
    let link: String
    let media: [String:String]
    let description: String
    let tags: String?
    var type: ImageType
}

enum ImageType: Int {
    case real
    case dummy
}


