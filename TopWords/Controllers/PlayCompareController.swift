//
//  CompareController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit
import Foundation

class PlayCompareController: UIViewController {
    
    @IBOutlet weak var viewFirstWord: UIView!
    @IBOutlet weak var viewSecondWord: UIView!
    @IBOutlet weak var lblCompare: UILabel!
    @IBOutlet weak var lblWordToTranslate: UILabel!
    @IBOutlet weak var lblTranslatedWord: UILabel!
    
    var animationsController = AnimationsController()
    var wordToTranslate = String()
    var translatedWord = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        lblCompare.text = K.Labels.playCardsMiddle
        viewFirstWord.alpha = 0
        viewSecondWord.alpha = 0
        showComparisonCards()
    }
    func showComparisonCards() {        
        
        animationsController.performObjectAnimation(point1: K.Animations.pointShort, point2: K.Animations.pointLarge, object: viewFirstWord, label: lblWordToTranslate, labelValue: wordToTranslate)
        animationsController.performObjectAnimation(point1: -K.Animations.pointShort, point2: -K.Animations.pointLarge, object: viewSecondWord, label: lblTranslatedWord, labelValue: translatedWord)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
