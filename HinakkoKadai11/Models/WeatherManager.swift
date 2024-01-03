//
//  WeatherManager.swift
//  HinakkoKadai11
//
//  Created by Hina on 2023/08/05.
//

import Foundation
//🟩Delegateをprotocolで定義
protocol WeatherManagerDelegate {
    //要求が設定される
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
//管理するものにマネージャーは意味が広い
struct WeatherManager {

    var lat: String
    var lon: String

    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&lang=ja&appid=\(Constants.apiKey)&units=metric"

    //なんらかのクラスや構造体がデリゲートとして設定されていれば、delegateを呼び出して天気更新する指示ができる。
    //🟦「お〜い、〇〇して〜！」と指示を送りたい側
    var delegate: WeatherManagerDelegate?
    
    mutating func fetchWeather(weatherPrefecture: String) {
//        let prefectureLatLon = PrefectureLatLon()
        let prefectureLatLon = PrefectureLatLon().fetchLatLon(weatherPrefecture: weatherPrefecture)
        lat = prefectureLatLon.lat
        lon = prefectureLatLon.lon
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"


        performRequest(with: urlString)
    }

    //SwiftAPI
    func performRequest(with urlString: String) {
        //ネットワーク接続の4つのステップ
        //1.URLの作成
        guard let url = URL(string: urlString) else { return }
        //2.URLセッションの作成。ブラウザのようなもの
        let session = URLSession(configuration: .default)
        //3.セッションにタスクを与えることができる。URLSessionDataTask生成。関数として受け取る。
        let task = session.dataTask(with: url) { data, respose, error in
            if let error =  error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            if let safeData = data {
                if let weather = self.parseJSON(safeData) {
                    //ViewControllerに取得した値を渡す。
                    self.delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }
        //4.タスク開始を完了させる。タスクが中断されている場合、再開する。新しいタスクを作成すると中断した状態で開始される。
        task.resume()
    }


    //dataTaskから戻ってくるのはData型
    //JSON形式からデータを解析する
    //OpenWeatherMapからWeatherDataを取得し、JSONレスポンスを渡す
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        //JSONオブジェクトからデータ型のインスタンスをデコードできるオブジェクト
        let decoder = JSONDecoder()

        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            // isEmpty
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            let description = decodeData.weather[0].description
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, weatherName: description)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
