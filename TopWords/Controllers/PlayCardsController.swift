//
//  PlayCardsController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 30/08/22.
//


import UIKit
import Foundation
class PlayCardsController: UIViewController {
    
    @IBOutlet weak var btnCard: UIButton!
    var isOpen = false
    
    @IBAction func btnFlip(_ sender: UIButton) {
        if isOpen{
            isOpen = false
            let image = UIImage(named: "CardTopWordsBack")
            btnCard.setImage(image, for: .normal)
            UIView.transition(with: btnCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
        else{
            isOpen = true
            let image = UIImage(named: "CardTopWordsFront")
            btnCard.setImage(image, for: .normal)
            UIView.transition(with: btnCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        //btnCard.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        //btnCard.imageView?.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
        
    }
    
   

}
