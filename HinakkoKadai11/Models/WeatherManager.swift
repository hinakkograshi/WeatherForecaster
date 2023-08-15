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
    
    const APIKEY = process.env.React_APP_OPENWEATHERMAP_API_KEY;

    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&lang=ja&appid=React_APP_OPENWEATHERMAP_API_KEY&units=metric"
    //API_KEY_HERE = 07700360da3b993cae32a391753e3e8e
    //なんらかのクラスや構造体がデリゲートとして設定されていれば、delegateを呼び出して天気更新する指示ができる。
    //🟦「お〜い、〇〇して〜！」と指示を送りたい側
    var delegate: WeatherManagerDelegate?
    
    mutating func fetchWeather(weatherPrefecture: String) {
        switch weatherPrefecture {
        case "北海道":
            lat = "43.064301"
            lon = "141.346874"
        case "青森県":
            lat = "40.824622"
            lon = "140.740598"
        case "岩手県":
            lat = "39.7036"
            lon = "141.152709"
        case "宮城県":
            lat = "38.268812"
            lon = "140.872082"
        case "秋田県":
            lat = "39.718611"
            lon = "140.102401"
        case "山形県":
            lat = "38.240422"
            lon = "140.363592"
        case "福島県":
            lat = "37.750301"
            lon = "140.467522"
        case "茨城県":
            lat = "36.341793"
            lon = "140.446802"
        case "栃木県":
            lat = "36.566672"
            lon = "139.883093"
        case "群馬県":
            lat = "36.390698"
            lon = "139.060451"
        case "埼玉県":
            lat = "35.857431"
            lon = "139.648901"
        case "千葉県":
            lat = "35.605045"
            lon = "140.123325"
        case "東京都":
            lat = "35.689753"
            lon = "139.691731"
        case "神奈川県":
            lat = "35.447495"
            lon = "139.6424"
        case "新潟県":
            lat = "37.902419"
            lon = "139.023225"
        case "富山県":
            lat = "36.695275"
            lon = "137.211342"
        case "石川県":
            lat = "36.59473"
            lon = "136.625582"
        case "福井県":
            lat = "36.065219"
            lon = "136.221682"
        case "山梨県":
            lat = "35.664161"
            lon = "138.568459"
        case "長野県":
            lat = "36.651296"
            lon = "138.181239"
        case "岐阜県":
            lat = "35.391228,"
            lon = "136.722311"
        case "静岡県":
            lat = "34.976944"
            lon = "138.383009"
        case "愛知県":
            lat = "35.180344"
            lon = "136.906632"
        case "三重県":
            lat = "34.730272"
            lon = "136.508598"
        case "滋賀県":
            lat = "35.004528"
            lon = "135.868607"
        case "京都府":
            lat = "35.021393"
            lon = "135.755439"
        case "大阪府":
            lat = "34.686555"
            lon = "135.519474"
        case "兵庫県":
            lat = "34.691287"
            lon = "135.183061"
        case "奈良県":
            lat = "34.685326"
            lon = "135.832751"
        case "和歌山県":
            lat = "34.226041"
            lon = "135.167504"
        case "鳥取県":
            lat = "35.503867"
            lon = "134.237716"
        case "島根県":
            lat = "35.472324"
            lon = "133.05052"
        case "岡山県":
            lat = "34.661759"
            lon = "133.934399"
        case "広島県":
            lat = "34.396603"
            lon = "132.459621"
        case "山口県":
            lat = "34.18613"
            lon = "131.470497"
        case "徳島県":
            lat = "34.065756"
            lon = "134.559297"
        case "香川県":
            lat = "34.340045"
            lon = "134.043369"
        case "愛媛県":
            lat = "33.841669"
            lon = "132.765371"
        case "高知県":
            lat = "33.5597"
            lon = "133.531096"
        case "福岡県":
            lat = "33.606781"
            lon = "130.418307"
        case "佐賀県":
            lat = "33.24957"
            lon = "130.299804"
        case "長崎県":
            lat = "32.744814"
            lon = "129.8737"
        case "熊本県":
            lat = "32.789816"
            lon = "130.74169"
        case "大分県":
            lat = "33.238205"
            lon = "131.612625"
        case "宮崎県":
            lat = "31.911058"
            lon = "131.423883"
        case "鹿児島県":
            lat = "31.560166"
            lon = "130.557994"
        case "沖縄県":
            lat = "26.212418"
            lon = "127.680895"
        default:
            break
        }
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
    // 🟩performRequest(urlString: urlString)
        performRequest(with: urlString)
    }
    //🟩with追加
    //SwiftAPI
    func performRequest(with urlString: String) {
        //ネットワーク接続の4つのステップ
        //1.URLの作成
        if let url = URL(string: urlString) {
            //2.URLセッションの作成。ブラウザのようなもの
            let session = URLSession(configuration: .default)
            //3.セッションにタスクを与えることができる。URLSessionDataTask生成。関数として受け取る。
            let task = session.dataTask(with: url) { data, respose, error in
                //オプショナルバインディング
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
    }

    //    func performRequest(with urlString: String) async throws {
    //        //ネットワーク接続の4つのステップ
    //        //1.URLの作成
    //        let url = URL(string: urlString)!
    //
    //            let task = try await URLSession.shared.dataTask(with: url) { data, respose, error in
    //                //ネットワーク処理全体にエラーがないかどうかをチェック
    //                if error !=  nil {
    //                    self.delegate?.didFailWithError(error: error!)
    //                    return
    //                }
    //                if let safeData = data {
    //                    if let weather = self.parseJSON(safeData) {
    //                        //ViewControllerに取得した値を渡す。
    //                        self.delegate?.didUpdateWeather(self, weather: weather)
    //                    }
    //                }
    //            }
    //            //4.タスク開始を完了させる。タスクが中断されている場合、再開する。新しいタスクを作成すると中断した状態で開始される。
    //            task.resume()
    //    }
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
