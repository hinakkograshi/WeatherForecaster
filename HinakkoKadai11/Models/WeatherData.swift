//
//  WeatherData.swift
//  HinakkoKadai11
//
//  Created by Hina on 2023/08/06.
//

import Foundation

//JSON形式からデコード
struct WeatherData : Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
