//
//  WestherData.swift
//  Weather
//
//  Created by Josué Amorim on 02/08/22.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    
    let description: String
}

