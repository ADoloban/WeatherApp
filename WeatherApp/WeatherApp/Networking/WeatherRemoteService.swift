//
//  WeatherRemoteService.swift
//  WeatherApp
//
//  Created by Artem Doloban on 07.12.2023.
//

import UIKit

final class WeatherRemoteService {
    func getWeather(for city: String, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        let urlStr = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=c9aa4fd43d5fed529ebe21faf8b95eb1&units=metric"
        guard let url = URL(string: urlStr) else { return }

        let session = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            self?.handleResponce(data: data, response: response, error: error, completion: completion)
        }

        session.resume()
    }

    private func handleResponce(data: Data?,
                                response: URLResponse?,
                                error: Error?,
                                completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        if let error {
            completion(.failure(error))
            return
        }

        guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode <= 299 else {
            completion(.failure(WeatherRemoteServiceError.failedNetworkStatusCode))
            return
        }

        guard let data else {
            completion(.failure(WeatherRemoteServiceError.noData))
            return
        }

        do {
            let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
            completion(.success(weatherModel))
        } catch {
            completion(.failure(error))
        }
    }

}

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
