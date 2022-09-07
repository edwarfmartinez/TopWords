//
//  PlayCardsController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 30/08/22.
//

import UIKit
import Foundation

protocol PlayCardsDelegate {
    func didFlipCard(_ playCardsController: PlayCardsController)
    func didFailWithError(error: Error)
}

class PlayCardsController: UIViewController {
    
    @IBOutlet weak var lblPlayCardsTop: UILabel!
    @IBOutlet weak var lblAskedWord: UILabel!
    @IBOutlet weak var btnCard: UIButton!
    @IBOutlet weak var lblPlayCardsBottom: UILabel!
    @IBOutlet weak var lblTranslatedWord: UILabel!
    @IBOutlet weak var viewAskedWord: UIView!
    
    var animationsController = AnimationsController()
    var playCardsDelegate: PlayCardsDelegate?
    var isOpen = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCard.imageView!.contentMode = .scaleAspectFit
        lblPlayCardsTop.text = K.Labels.playCardsTop
        lblAskedWord.text = "Test"
        lblPlayCardsBottom.text = K.Labels.playCardsBottomBeforeFlip
        self.lblAskedWord.alpha = 0
        
        
        showWordToTranslate()
    }
    /*
     func disapearWordToTranslate() {
     UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
     self.lblAskedWord.transform = CGAffineTransform(translationX: -30, y: 0)
     }) { (_) in
     UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
     self.lblAskedWord.alpha = 0
     self.lblAskedWord.transform = CGAffineTransform(translationX: -30, y: -150)
     }, completion: { (_) in
     
     })
     }
     }
     */
    
    func showWordToTranslate() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.lblAskedWord.alpha = 0
            self.lblAskedWord.transform = CGAffineTransform(translationX: 0, y: -150)
        }) { (_) in
            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.lblAskedWord.transform = CGAffineTransform(translationX: -30, y: -150)
            }) { (_) in
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                    self.lblAskedWord.alpha = 1
                    self.lblAskedWord.transform = CGAffineTransform(translationX: -30, y: 0)
                }) { (_) in
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                        self.lblAskedWord.transform = CGAffineTransform(translationX: 0, y: 0)
                    }, completion: { (_) in
                        
                    })
                }
            }
        }
    }
    @IBAction func btnFlip(_ sender: UIButton) {
        if !isOpen{
            lblTranslatedWord.text = "Prueba"
            lblPlayCardsBottom.text = K.Labels.playCardsBottomAfterFlip
            
            startAnimation(cardImageName: K.Images.cardFront)
            self.playCardsDelegate?.didFlipCard(self)
            
            
        }
    }
    
    func startAnimation(cardImageName: String){
        let image = UIImage(named: cardImageName)
        btnCard.setImage(image, for: .normal)
        performTransition(elementToAnimate: btnCard)
        performTransition(elementToAnimate: lblTranslatedWord)
        performTransition(elementToAnimate: lblPlayCardsBottom)
        isOpen = cardImageName == K.Images.cardFront ? true : false
    }
    
    func performTransition(elementToAnimate: UIView){
        UIView.transition(with: elementToAnimate, duration:  K.cardFlipTimer, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
}
