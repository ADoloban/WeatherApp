//
//  WeatherResponceObject.swift
//  WeatherApp
//
//  Created by Artem Doloban on 09.12.2023.
//

import UIKit

// MARK: - Weather
struct WeatherModel: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Decodable {
    let lat, lon: Double
}

// MARK: - List
struct List: Decodable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct Clouds: Decodable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Decodable {
    let pod: Pod
}

enum Pod: String, Decodable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main: MainEnum
    let description: Description
}

enum Description: String, Decodable {
    case brokenClouds = "broken clouds"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case clearSky = "clear sky"
    
    var image: UIImage {
            switch self {
            case .brokenClouds:
                return UIImage(systemName: "cloud.fill") ?? UIImage()
            case .fewClouds:
                return UIImage(systemName: "cloud.sun.fill") ?? UIImage()
            case .lightRain:
                return UIImage(systemName: "cloud.sun.rain.fill") ?? UIImage()
            case .moderateRain:
                return UIImage(systemName: "cloud.sun.rain.fill") ?? UIImage()
            case .overcastClouds:
                return UIImage(systemName: "cloud.sun.rain.fill") ?? UIImage()
            case .scatteredClouds:
                return UIImage(systemName: "cloud.sun.rain.fill") ?? UIImage()
            case .clearSky:
                return UIImage(systemName: "sun.max.fill") ?? UIImage()
            }
        }
}

enum MainEnum: String, Decodable {
    case clouds = "Clouds"
    case rain = "Rain"
    case clear = "Clear"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
