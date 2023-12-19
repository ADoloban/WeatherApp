//
//  WeatherRemoteServiceError.swift
//  WeatherApp
//
//  Created by Artem Doloban on 09.12.2023.
//

import Foundation

enum WeatherRemoteServiceError: Error {
    case failedNetworkStatusCode
    case noData
    case jsonDecode
    case defaultError

    var description: String {
        switch self {
        case .failedNetworkStatusCode:
            "Network request failed"

        case .noData:
            "The data did not come"
        
        case .jsonDecode:
            "Problem with JSONDecoder"
            
        case .defaultError:
            "Error"
        }
    }
}
