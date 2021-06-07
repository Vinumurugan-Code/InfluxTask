//
//  APIService.swift
//  Influx Task
//
//  Created by vinumax on 07/06/21.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case GET
    case POST
}

class APIService: NSObject {
    
    static let shared = APIService()
    
    let session = URLSession(configuration: .default)
    
    func getResponse<T:Decodable>(_ method:HTTPMethod? = .GET,responseType: T.Type, completionHandler: @escaping(Result<T,Error>) -> Void) {
        
        var request = URLRequest(url:URL(string:"https://picsum.photos/v2/list?page=1&limit=20")!)
                                
        request.httpMethod = method?.rawValue
            
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let dataObj = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(dataObj))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
            }
        }.resume()
    }
}



struct Cache {
   static let imgCache =  NSCache<NSString, UIImage>()
}
