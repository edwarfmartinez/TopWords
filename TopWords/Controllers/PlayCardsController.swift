//
//  PlayCardsController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 30/08/22.
//

import UIKit

protocol PlayCardsDelegate {
    func didCloseCard(_ playCardsController: PlayCardsController)
    func didFailWithError(error: Error)
}

class PlayCardsController: UIViewController {
    
    @IBOutlet weak var lblWordToTranslate: UILabel!
    @IBOutlet weak var btnCard: UIButton!
    @IBOutlet weak var lblTranslatedWord: UILabel!
    @IBOutlet weak var lblPlayCardsFooter: UILabel!
    
    var animationsController = AnimationsController()
    var wordToTranslate = String()
    var translatedWord = String()
    var playCardsDelegate: PlayCardsDelegate?
    var isCardOpen = false
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
                
        super.viewDidLoad()
        // DB path
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        btnCard.imageView!.contentMode = .scaleAspectFit
        lblPlayCardsFooter.text = K.Labels.playCardsFooterBeforeFlip
        lblWordToTranslate.alpha = 0
        lblWordToTranslate.text = wordToTranslate
        lblTranslatedWord.text = translatedWord
        lblTranslatedWord.isHidden = true
        animationShowWordToTranslate()
        
    }
    
    func animationShowWordToTranslate(){
        animationsController.performObjectAnimation(point1: K.Animations.pointShort, point2: K.Animations.pointLarge, object: lblWordToTranslate, label: lblWordToTranslate, labelValue: wordToTranslate)
    }
    
    @IBAction func btnShowCardFront(_ sender: UIButton) {
       
        if !isCardOpen{
            lblTranslatedWord.text = translatedWord
            lblPlayCardsFooter.text = K.Labels.playCardsFooterAfterFlip
            startFlipCardAnimation(cardImageName: K.Images.cardFront)
            self.playCardsDelegate?.didCloseCard(self)
        }
    }
    
    func startFlipCardAnimation(cardImageName: String){
        lblTranslatedWord.isHidden = false
        let image = UIImage(named: cardImageName)
        //btnCard.setImage(image, for: .normal)
        btnCard.setBackgroundImage(image, for: .normal)
        performTransition(elementToAnimate: btnCard)
        performTransition(elementToAnimate: lblTranslatedWord)
        performTransition(elementToAnimate: lblPlayCardsFooter)
        isCardOpen = cardImageName == K.Images.cardFront ? true : false
    }
    
    func performTransition(elementToAnimate: UIView){
        UIView.transition(with: elementToAnimate, duration:  K.Animations.cardFlipTimer, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}


@IBDesignable extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
              layer.cornerRadius = newValue

              // If masksToBounds is true, subviews will be
              // clipped to the rounded corners.
              layer.masksToBounds = (newValue > 0)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
            get { return layer.shadowRadius }
            set { layer.shadowRadius = newValue }
        }

        @IBInspectable var shadowOpacity: CGFloat {
            get { return CGFloat(layer.shadowOpacity) }
            set { layer.shadowOpacity = Float(newValue) }
        }

        @IBInspectable var shadowOffset: CGSize {
            get { return layer.shadowOffset }
            set { layer.shadowOffset = newValue }
        }

        @IBInspectable var shadowColor: UIColor? {
            get {
                guard let cgColor = layer.shadowColor else {
                    return nil
                }
                return UIColor(cgColor: cgColor)
            }
            set { layer.shadowColor = newValue?.cgColor }
        }
}
