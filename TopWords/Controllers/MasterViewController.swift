//
//  MasterViewController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 31/08/22.
//

import Foundation
import UIKit
//import XCTest

class MasterViewController: UIViewController{
    
    @IBOutlet weak var containerPlayCards: UIView!
    @IBOutlet weak var containerCompare: UIView!
    @IBOutlet weak var containerScore: UIView!
    @IBOutlet weak var btnHit: UIButton!
    @IBOutlet weak var btnFail: UIButton!
    @IBOutlet weak var imgAnimationWhenTapButton: UIImageView!
    @IBOutlet weak var lblHits: UILabel!
    @IBOutlet weak var lblFails: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    
    var animationsController = AnimationsController()
    var playCardsController: PlayCardsController?
    var playCompareController: PlayCompareController?
    var resultsViewController: ScoreViewController?
    var failsOnly = false
    var basicLevel = true
    var intermediateLevel = true
    var advancedLevel = true
    var dataAccessController: DataAccessController?
    var showWordToTranslateInEnglish = Bool()
    var showWrongComparison = Bool()
    var wordIndex = Int()
    var gameIndex = 0
    var segueName = String()
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    
    override func viewDidLoad() {
        
        self.title = segueName
        visualizeContainer(fromSegue: segueName)
        updateScoreLabels()
        dataAccessController!.gameIndex = gameIndex
    }
    
    func visualizeContainer(fromSegue: String){
        
        containerPlayCards.isHidden = true
        containerCompare.isHidden = true
        containerScore.isHidden = true
        
        switch fromSegue {
        case K.Segues.playCards:
            containerPlayCards.isHidden = false
            lblHeader.text = K.Labels.playCardsHeader
            enableBottomButtons(isEnabled: false)
            
        case K.Segues.playCompare:
            containerCompare.isHidden = false
            lblHeader.text = K.Labels.playCompareHeader
            
            //Set response buttons
            btnHit.setImage(nil, for: .normal)
            btnHit.setTitle(K.Labels.btnTrue, for: .normal)
            btnFail.setImage(nil, for: .normal)
            btnFail.setTitle(K.Labels.btnFalse, for: .normal)
            
        default:
            containerScore.isHidden = false
            lblHeader.text = K.Labels.scoreHeader
            btnHit.setTitle(K.Labels.btnTrue, for: .normal)
            //Set response buttons
            btnHit.setImage(nil, for: .normal)
            btnHit.setTitle(K.Labels.btnScoreHits, for: .normal)
            btnFail.setImage(nil, for: .normal)
            btnFail.setTitle(K.Labels.btnScoreFails, for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        dataAccessController = DataAccessController(failsOnly: failsOnly, basicLevel: basicLevel, intermediateLevel: intermediateLevel, advancedLevel: advancedLevel)
        let randomWord = selectedRandomWord()
        
        if segue.identifier == K.Segues.playCards {
            
            let vc = segue.destination as? PlayCardsController
            setNewGamePlayCards(vc!, randomWord)
            vc!.playCardsDelegate = self
            self.playCardsController = vc
            return
        }
        
        if segue.identifier == K.Segues.playCompare {
            
            let vc = segue.destination as? PlayCompareController
            setNewGamePlayCompare(vc!, randomWord)
            self.playCompareController = vc
            return
        }
        
        if segue.identifier == K.Segues.checkScore {
            let vc = segue.destination as? ScoreViewController
            self.resultsViewController = vc
            return
        }
    }
        
    fileprivate func setNewGamePlayCompare(_ vc: PlayCompareController, _ randomWord: (wordToTranslate: String, translatedWord: String)) {
        
        showWrongComparison = Bool.random()
        switch (showWrongComparison,showWordToTranslateInEnglish)
        {
        case (false, false): do {
            vc.wordToTranslate = randomWord.translatedWord
            vc.translatedWord = randomWord.wordToTranslate
        }
        case (false, true): do {
            vc.wordToTranslate = randomWord.wordToTranslate
            vc.translatedWord = randomWord.translatedWord
        }
        case (true, false): do {
            vc.wordToTranslate = selectedRandomWord().translatedWord
            vc.translatedWord = randomWord.wordToTranslate
        }
        case (true, true): do {
            vc.wordToTranslate = randomWord.wordToTranslate
            vc.translatedWord = selectedRandomWord().translatedWord
        }
        }
    }
    
    fileprivate func setNewGamePlayCards(_ vc: PlayCardsController, _ randomWord: (wordToTranslate: String, translatedWord: String)) {
        
        guard showWordToTranslateInEnglish else {
            vc.wordToTranslate = randomWord.translatedWord
            vc.translatedWord = randomWord.wordToTranslate
            return
        }
        vc.wordToTranslate = randomWord.wordToTranslate
        vc.translatedWord = randomWord.translatedWord
    }
    
    func selectedRandomWord()->(wordToTranslate: String, translatedWord: String){
        
        let amountOfWords = dataAccessController!.words.count
        if amountOfWords > 1 {
            dataAccessController!.wordIndex = Int.random(in: 0..<amountOfWords-1)}
        else{
            dataAccessController!.wordIndex = 0
        }
        let randomWord = dataAccessController!.words[dataAccessController!.wordIndex]
        showWordToTranslateInEnglish = Bool.random()
        return (randomWord.english!.capitalizingFirstLetter(), randomWord.spanish!.capitalizingFirstLetter())
    }
    
    fileprivate func thumbAnimation(_ thumbUp: Bool) {
        //When thumb-up pressed call core animation
        view.addSubview(imgAnimationWhenTapButton)
        
        if(thumbUp){
            startPoint = CGPoint(x: K.Animations.Score.pointShort , y: view.frame.maxY - K.Animations.Score.pointLarge)
            endPoint = CGPoint(x: K.Animations.Score.pointShort, y: view.frame.minY)
            imgAnimationWhenTapButton.image = UIImage(systemName: K.Animations.Score.hitIcon)
            imgAnimationWhenTapButton.tintColor = K.Animations.Score.hitIconColor
        } else {
            startPoint = CGPoint(x: view.frame.maxX - K.Animations.Score.pointShort, y: view.frame.minY + K.Animations.Score.pointShort)
            endPoint = CGPoint(x: view.frame.maxX - K.Animations.Score.pointShort, y: view.frame.maxY)
            imgAnimationWhenTapButton.image = UIImage(systemName:K.Animations.Score.failIcon)
            imgAnimationWhenTapButton.tintColor = K.Animations.Score.failIconColor
        }
        
        let duration = K.Animations.Score.animationDuration
        let positionAnimation = animationsController.constructPositionAnimation(startingPoint: startPoint, endPoint: endPoint, animationDuration: duration)
        imgAnimationWhenTapButton.layer.add(positionAnimation, forKey: K.Animations.Score.positionKey)
        
        let opacityFadeAnimation = animationsController.constructOpacityAnimation(startingOpacity: K.Animations.Score.startingOpacity, endingOpacity: 0.0, animationDuration: duration)
        imgAnimationWhenTapButton.layer.add(opacityFadeAnimation, forKey: K.Animations.Score.opacityKey)
    }
    
    
    @IBAction func didTapFooterButton(_ sender: UIButton) {
        
        //Configure this to share info between parent and child
        
        if let vc = playCardsController, segueName == K.Segues.playCards {
            dataAccessController!.UpdateScore(hit: sender.tag == 0 ? true : false)
            updateScoreLabels()
            //Close card and start new game (New word)
            vc.lblTranslatedWord.text = ""
            vc.lblPlayCardsFooter.text = K.Labels.playCardsFooterBeforeFlip
            vc.startFlipCardAnimation(cardImageName: K.Images.cardBack)
            
            let randomWord = selectedRandomWord()
            setNewGamePlayCards(vc, randomWord)
            vc.animationShowWordToTranslate()
            thumbAnimation(sender.tag == 0 ? true : false)
            enableBottomButtons(isEnabled: false)
        }
        
        if let vc = playCompareController, segueName == K.Segues.playCompare {
            let userAnswerWasCorrect =
            (sender.tag == 0 && !showWrongComparison) || (sender.tag == 1 && showWrongComparison) ? true : false
            dataAccessController!.UpdateScore(hit: userAnswerWasCorrect)
            updateScoreLabels()
            thumbAnimation(userAnswerWasCorrect)
            setNewGamePlayCompare(vc, selectedRandomWord())
            vc.showComparisonCards()
            Timer.scheduledTimer(withTimeInterval: K.timerDisableButtonsAnswer, repeats: false, block: { [self] _ in
                enableBottomButtons(isEnabled: true)
            })
        }
        
        if let vc = resultsViewController, segueName == K.Segues.checkScore {
            sender.tag == 0 ? vc.sortScoreResults(byHits: true) : vc.sortScoreResults(byHits: false)
        }
    }
    
    func enableBottomButtons(isEnabled: Bool) {
        btnHit.isEnabled = isEnabled
        btnFail.isEnabled = isEnabled
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateScoreLabels() {
        lblHits.text = String(dataAccessController!.score.reduce(0) { $0 + ($1.hits) })
        lblFails.text = String(dataAccessController!.score.reduce(0) { $0 + ($1.fails) })
    }
}

//MARK: Delegates
extension MasterViewController: PlayCardsDelegate{
    func didCloseCard(_ playCardsController: PlayCardsController) {
        enableBottomButtons(isEnabled: true)
    }
    func didFailWithError(error: Error) {
        print("\(K.Errors.playCardsDelegate) \(error)")
    }
}
