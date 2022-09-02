//
//  CompareController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit

class PlayCompareController: UIViewController {
    
    
    
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBAction func dismissSecondVC(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
//        if segue.identifier == K.Segues.toScore {
//            
//            let destVC = segue.destination as! ScoreViewController
//            destVC.hits = 1
//            destVC.fails = 2
//            
//        }
//    }
}
