//
//  ViewController.swift
//  HinakkoKadai11
//
//  Created by Hina on 2023/06/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var selectLabel: UILabel!

    @IBAction func first(segue: UIStoryboardSegue) {
        if segue.identifier == "toNext" {
            let prefectureViewController = segue.source as? PrefectureViewController
            selectLabel.text = prefectureViewController?.selectedPrefecture
        }
    }
    @IBAction func cancel(segue: UIStoryboardSegue) {
    }
}

