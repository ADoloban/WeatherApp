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

    var description: String {
        switch self {
        case .failedNetworkStatusCode:
            "Network request failed"

        case .noData:
            "..."
        }
    }
}
