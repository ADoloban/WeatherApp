//
//  WeatherRemoteService.swift
//  WeatherApp
//
//  Created by Artem Doloban on 07.12.2023.
//

import UIKit

final class WeatherRemoteService {
    
    let url = "https://api.openweathermap.org/data/2.5/forecast?q=London&appid=c9aa4fd43d5fed529ebe21faf8b95eb1&units=metric"
    
    func getWeather(completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            self.handleResponce(data: data, error: error, completion: completion)
        }
        
        session.resume()
    }
    
    private func handleResponce(data: Data?,
                                       error: Error?,
                                       completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        if let error = error {
            print(error)
        } else if let data = data {
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(WeatherModel.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("error \(error)")
            }
        } else {
            print("error")
        }
    }
}
