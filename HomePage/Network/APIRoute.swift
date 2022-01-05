//
//  APIRoute.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import Foundation

class APIRoute{
    
    private class func initRequest(_ clientRequest:ProjectNetwork)->URLRequest? {
        
        var components = URLComponents(string: clientRequest.base)!
        components.path = "/" + clientRequest.path
        components.queryItems = clientRequest.queryItems
        
        guard let url = components.url else { return nil}
        var request = URLRequest(url: url)
        
        request.httpMethod = clientRequest.method.rawValue
        if clientRequest.body != nil{
            let jsonData = try? JSONSerialization.data(withJSONObject: clientRequest.body, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        return request
    }
    
    class func fetchRequest<T: Codable>(clientRequest: ProjectNetwork, decodingModel: T.Type, completion: @escaping (Result<T, Error>) -> ()){
        
        guard let urlRequest:URLRequest = APIRoute.initRequest(clientRequest) else {return}
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard response != nil, let data = data else { return}
            var responseObject: T!
            DispatchQueue.main.async {
                do {
                    responseObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseObject))
                }catch let err{
                    completion(.failure(err))
                }
            }
        }
        dataTask.resume()
    }
}
