////
//  WeatherResponceObject.swift
//  WeatherApp
//
//  Created by Artem Doloban on 09.12.2023.
//

import UIKit

// MARK: - Weather
struct WeatherModel: Decodable {
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Decodable {
    let name: String
    let timezone: Int
}

// MARK: - List
struct List: Decodable {
    let dt: Int
    let dtTxt: String
    let main: MainClass
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt, main, weather
        case dtTxt = "dt_txt"
    }

    var weekDay: String {
        let dateFormatter = DateFormatter()
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let weekday = Calendar.current.component(.weekday, from: date)
        return dateFormatter.weekdaySymbols[weekday - 1]
    }
    
    var hour: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var hourFromDate: Int = 0
        
        if let date = dateFormatter.date(from: dtTxt){
            hourFromDate = Calendar.current.component(.hour, from: date)
        }
        
        switch hourFromDate {
        case 0:
            return "00"
        case 3:
            return "03"
        case 6:
            return "06"
        case 9:
            return "09"
        case 12:
            return "12"
        case 15:
            return "15"
        case 18:
            return "18"
        case 21:
            return "21"
        default:
            return "  "
        }
    }
    
}

// MARK: - MainClass
struct MainClass: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

// MARK: - Weather
struct Weather: Decodable {
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
