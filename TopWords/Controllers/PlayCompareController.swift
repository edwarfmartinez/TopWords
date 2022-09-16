//
//  CompareController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit
//import CoreData
import Foundation

protocol PlayCompareDelegate {
    func didShowComparison(rightAnswer: Bool, selectedWord: String)
    func didFailWithError(error: Error)
}
class PlayCompareController: UIViewController {
    @IBOutlet weak var viewFirstWord: UIView!
    @IBOutlet weak var viewCompare: UIView!
    @IBOutlet weak var viewSecondWord: UIView!
    @IBOutlet weak var lblCompare: UILabel!
    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var lblTranslatedWord: UILabel!
    
    var animationsController = AnimationsController()
    var playCompareDelegate: PlayCompareDelegate?
    var dataAccessController = DataAccessController()
    var generalPurposes = GeneralPurposes()
    var showTrueComparison = Bool()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        lblCompare.text = K.Labels.playCardsMiddle
        viewFirstWord.alpha = 0
        viewSecondWord.alpha = 0
        
        dataAccessController.loadWords()
        dataAccessController.loadGames()
        createComparison()
        showComparisonCards()
    }
    
    func createComparison(){
        showTrueComparison = Bool.random()
        let showTopCardInEnglish = Bool.random()
        dataAccessController.wordIndex = Int.random(in: 0..<dataAccessController.words.count-1)
        //print("showTrueComparison:\(showTrueComparison) - showTopCardInEnglish:\(showTopCardInEnglish)")
        
        if showTrueComparison {
            if showTopCardInEnglish {
                lblWord.text = dataAccessController.words[dataAccessController.wordIndex].english!.capitalizingFirstLetter()
                lblTranslatedWord.text = dataAccessController.words[dataAccessController.wordIndex].spanish!.capitalizingFirstLetter()
            } else {
                lblWord.text = dataAccessController.words[dataAccessController.wordIndex].spanish!.capitalizingFirstLetter()
                lblTranslatedWord.text = dataAccessController.words[dataAccessController.wordIndex].english!.capitalizingFirstLetter()
            }
        } else {
            let indexWord2 = Int.random(in: 0..<dataAccessController.words.count-1) //new word
            if showTopCardInEnglish {
                lblWord.text = dataAccessController.words[dataAccessController.wordIndex].english!.capitalizingFirstLetter()
                lblTranslatedWord.text = dataAccessController.words[indexWord2].spanish!.capitalizingFirstLetter()
            } else {
                lblWord.text = dataAccessController.words[dataAccessController.wordIndex].spanish!.capitalizingFirstLetter()
                lblTranslatedWord.text = dataAccessController.words[indexWord2].english!.capitalizingFirstLetter()
            }
        }
        /*
        print("PlayCompareController - dataAccess.wordIndex: \(dataAccess.wordIndex)")
        playCompareDelegate?.didShowComparison(rightAnswer: showTrueComparison, selectedWord: dataAccess.words[dataAccess.wordIndex].english!)
         */
    }
    
    func showComparisonCards() {
        animationsController.performObjectAnimation(point1: K.Animations.pointShort, point2: K.Animations.pointLarge, object: viewFirstWord)
        animationsController.performObjectAnimation(point1: -K.Animations.pointShort, point2: -K.Animations.pointLarge, object: viewSecondWord)
 
        
    }
    
    func updateScore(userAnswer: Bool){
        dataAccessController.UpdateScore(hit: userAnswer == showTrueComparison ? true : false, game: 1)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
