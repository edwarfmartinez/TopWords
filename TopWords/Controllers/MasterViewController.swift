//
//  MasterViewController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 31/08/22.
//

import Foundation
import UIKit

class MasterViewController: UIViewController, UIViewControllerTransitioningDelegate{
    
    @IBOutlet weak var containerPlayCards: UIView!
    @IBOutlet weak var containerCompare: UIView!
    @IBOutlet weak var containerScore: UIView!
    
 
    var segueName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualizeContainer(fromSegue: segueName)
        
       
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let secondVC = segue.destination as! PlayCompareController
//        
//        secondVC.transitioningDelegate = self
//        secondVC.modalPresentationStyle = .custom
    }
    
    func visualizeContainer(fromSegue: String){
        
        switch fromSegue {
        case K.Segues.toPlayCards:
            containerPlayCards.isHidden = false
            containerCompare.isHidden = true
            containerScore.isHidden = true
        case K.Segues.toPlayCompare:
            containerPlayCards.isHidden = true
            containerCompare.isHidden = false
            containerScore.isHidden = true
        default:
            containerPlayCards.isHidden = true
            containerCompare.isHidden = true
            containerScore.isHidden = false
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
