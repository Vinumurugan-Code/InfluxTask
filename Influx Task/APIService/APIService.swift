//
//  APIService.swift
//  Vinu Notes App
//
//  Created by vinumax on 23/03/21.
//

import Foundation
import UIKit

class APIService {
        
    var urlComponents: URLComponents
    
    var currentSearchTag = "nature"
    
    init() {
        urlComponents = URLComponents(string: "https://api.flickr.com/")!
        urlComponents.queryItems = [
            URLQueryItem(name: "lang", value: "en-us"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "tags", value: currentSearchTag),
            URLQueryItem(name: "nojsoncallback", value: "1"),
        ]
    }
        
    func getResponse<T:Decodable>(_ path: String,responseType: T.Type, completionHandler: @escaping(Result<T,Error>) -> Void) {
        
        urlComponents.path = path
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, response, error in
            guard error == nil else {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                let item = try JSONSerialization.data(withJSONObject: json["items"]!, options: [])
                let decoder = JSONDecoder()
                let dataObj = try decoder.decode(T.self, from: item)
                DispatchQueue.main.async {
                    completionHandler(.success(dataObj))
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
        task.resume()
    }
}
