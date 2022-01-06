//
//  HomePage.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 05/01/2022.
//

import Foundation

enum HomePage{
    case GetData
}

extension HomePage: Endpoint{
    var base: String {
        return Bundle.main.baseURL
    }
    
    var urlSubFolder: String {
        return Bundle.main.urlSubFolder
    }
    
    var path: String {
        switch self{
        case .GetData:
            return "main"
        }
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
    
    var method: HTTPMethod {
        switch self{
        default:
            return .get
        }
    }
    
    var body: [String: Any]?{
        return nil
    }
    
}


extension Bundle {
    var baseURL: String {
        return object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    }
    
    var urlSubFolder: String {
        return object(forInfoDictionaryKey: "URLSubFolder") as? String ?? ""
    }
    
    var storesImagesURL: String{
        return object(forInfoDictionaryKey: "StoresImagesURL") as? String ?? ""
    }
    
    var categoriesImagesURL: String{
        return object(forInfoDictionaryKey: "CategoriesImagesURL") as? String ?? ""
    }
    
    var offersImagesURL: String{
        return object(forInfoDictionaryKey: "OffersImageURL") as? String ?? ""
    }
}
