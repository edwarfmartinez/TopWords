//
//  FirstChildVC.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit

class ScoreViewController: UIViewController{
    
    @IBOutlet weak var lblHits: UILabel!
    @IBOutlet weak var lblFails: UILabel!
    
    var hits: Int = 0
    var fails: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblHits.text = String(hits)
        lblFails.text = String(fails)
    }
    
}


