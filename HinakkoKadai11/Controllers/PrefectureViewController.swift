//
//  PrefectureViewController.swift
//  HinakkoKadai11
//
//  Created by Hina on 2023/06/28.
//

import UIKit

class PrefectureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let data = PrefectureData()
    var selectedPrefecture: String?

    @IBOutlet weak var tableview: UITableView!
    //データソースにテーブルビュー内のセクションの数を返すように要求します。
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //テーブル ビューの特定のセクションの行数を返すようにデータ ソースに指示します。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.prefectureList.count
    }
    //テーブルビューの特定の場所にセルを挿入するようにデータソースに要求。表示する内容をつくってセルに返す。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as UITableViewCell
        cell.textLabel?.text = data.prefectureList[indexPath.row]
        return cell
    }
    //行が選択されていることをデリゲートに伝える。didSelectRowAtがCellを触ったといことを感知している。
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prefecture = data.prefectureList[indexPath.row]
        self.selectedPrefecture = prefecture
        performSegue(withIdentifier: "toNext", sender: nil)
    }
}
