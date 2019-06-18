//
//  WebSevice.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/14/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class WebService {
    
    func load<T>(resource: Resource<T>, completion: @escaping(T?) -> ()) {
        
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
          
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))

                }
            }else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            
        }.resume()
    }
}
