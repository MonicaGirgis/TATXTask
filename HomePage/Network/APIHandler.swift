//
//  APIHandler.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import Foundation

public enum HTTPMethod: String{
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

protocol Endpoint{
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}
