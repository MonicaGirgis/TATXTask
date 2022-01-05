//
//  APIError.swift
//  FFLASHH
//
//  Created by Moca Girges on 22/05/2021.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case message(value: GeneralErrorMessage)
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:
            return "Please check your connection and try again later".localized()
        case .invalidData:
            return "Invalid Data".localized()
        case .responseUnsuccessful:
            return "Response Unsuccessful".localized()
        case .jsonParsingFailure:
            return "JSON Parsing Failure".localized()
        case .jsonConversionFailure:
            return "JSON Conversion Failure".localized()
        case .message(let value):
            guard let errorMessage = value.message else { return "No Error Message".localized()}
            return errorMessage
        }
    }
}
