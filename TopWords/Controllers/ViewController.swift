//
//  ViewController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        
        let destVC = segue.destination as! MasterViewController
        destVC.segueName = segue.identifier!
        
    }
}