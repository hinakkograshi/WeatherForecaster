//
//  ViewController.swift
//  HinakkoKadai11
//
//  Created by Hina on 2023/06/26.
//

import UIKit

class ViewController: UIViewController, WeatherManagerDelegate {
    
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var selectLabel: UILabel!
    var weatherManager = WeatherManager(lat: "", lon: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //クラスをデリゲートとして設定
        weatherManager.delegate = self
    }
    
    @IBAction func first(segue: UIStoryboardSegue) {
        if segue.identifier == "toNext" {
            let prefectureViewController = segue.source as? PrefectureViewController
            selectLabel.text = prefectureViewController?.selectedPrefecture
            if let prefecture = selectLabel.text {
                weatherManager.fetchWeather(weatherPrefecture: prefecture)
            }
        }
    }
    @IBAction func cancel(segue: UIStoryboardSegue) {
    }
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.weatherImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.weatherLabel.text = weather.weatherName
        }
    }
    func didFailWithError(error: Error) {
        print("ネットワーク通信できませんエラー")
    }
}
