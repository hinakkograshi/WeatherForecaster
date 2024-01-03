# API通信学習用ミニアプリ
Open Weather APIを使用したミニアプリです。
URL: https://openweathermap.org/current

選択ボタンを押し、遷移先の47都道府県のTableViewCellから都道府県を1つ選択し、天気を取得することができるアプリです。


https://github.com/hinakkograshi/WeatherForecaster/assets/131275914/a43836e0-ae75-4ccf-a333-bab8684171b0

### オブジェクト間のイベント通知方法
**デリゲートパターンを採用してます。**
デリゲート元のオブジェクトは適切なタイミングで、デリゲート先のオブジェクトにメッセージを送る。
デリゲートパターンを用いると、デリゲート先のオブジェクトを切り替えることでデリゲート元の振る舞いを柔軟に変更可能。
必要な処理はプロトコルとして事前に宣言されている必要があり、記述するコードは多くなる。

## gitignore
gitignoreにConstants.swiftが入っています！
動かしたい場合、ご自身で取得した"APIKey"を置き換えてください！
```
struct Constants {
     static let apiKey = "APIKey"
 }
```
