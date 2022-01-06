//
//  HomeData.swift
//  HomePage
//
//  Created by Monica Girgis Kamel on 05/01/2022.
//

import Foundation

struct HomeData: Codable{
    var error: Int
    var message: String
    var result: DataResult
    
    enum CodingKeys: String, CodingKey{
        case error = "error_flag"
        case message, result
    }
}

struct DataResult: Codable{
    var offers: [Offer]
    var categories: [Category]
    var main: [Main]
    var storesImage: String
    var categoriesImage: String
    var offersImage: String
    
    enum CodingKeys: String, CodingKey{
        case offers, categories, main
        case storesImage = "stores_image_url"
        case categoriesImage = "categories_image_url"
        case offersImage = "offers_image_url"
    }
}

struct Offer: Codable{
    var id: String
    var image: String?
}

struct Category: Codable{
    var id: String
    var nameEn: String
    var nameAr: String
    var image: String?
    
    enum CodingKeys:String, CodingKey{
        case id, image
        case nameEn = "name_en"
        case nameAr = "name_ar"
    }
}

struct Main: Codable{
    var titleAr: String
    var titleEn: String
    var viewType: String
    var stores: [Store]
    
    enum CodingKeys: String, CodingKey{
        case titleAr = "title_ar"
        case titleEn = "title_en"
        case viewType = "view_type"
        case stores
    }
}

struct Store: Codable{
    
    var id: String
    var nameAr: String
    var nameEn: String
    var image: String
    var category: Category
    var deliveryFees: Double
    var from: Int
    var to: Int
    var deliveryTimeAr: String
    var deliveryTimeEn: String
    var isOpened: Int
    var distance: Int
    var ordersType: String
    
    
    enum CodingKeys: String, CodingKey{
        case id, image, category, distance
        case nameEn = "name_en"
        case nameAr = "name_ar"
        case deliveryFees = "delivery_fees"
        case from = "duration_from"
        case to = "duration_to"
        case deliveryTimeAr = "delivery_time_ar"
        case deliveryTimeEn = "delivery_time_en"
        case isOpened = "is_opened"
        case ordersType = "orders_type"
    }
}
 
