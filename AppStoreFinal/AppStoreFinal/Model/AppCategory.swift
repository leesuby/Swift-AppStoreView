//
//  AppCategory.swift
//  AppStoreFinal
//
//  Created by LAP15335 on 31/08/2022.
//

import Foundation
import UIKit

struct FeaturedApps: Decodable {
    
    var bannerCategory: AppCategory?
    var categories: [AppCategory]?
    
}

struct AppCategory: Decodable {
    
    let name: String?
    let apps: [App]?
    let type: String?
    
    static func fetchFeaturedApps(_ completionHandler: @escaping (FeaturedApps) -> ()) {
        
        let urlString = "http://api.letsbuildthatapp.com/appstore/featured"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let featuredApps = try decoder.decode(FeaturedApps.self, from: data)
                print(featuredApps)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completionHandler(featuredApps)
                })
                
            } catch let err {
                print(err)
            }
            
        }) .resume()
        
    }
}

struct App: Decodable {
    
    let Id: Int?
    var Name: String?
    var Category: String?
    var ImageName: String?
    var Price: Float?
    
}
