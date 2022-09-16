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
    @IBOutlet weak var lblFooter: UILabel!
    
    var animationsController = AnimationsController()
    var playCardsController: PlayCardsController?
    var playCompareController: PlayCompareController?
    var dataAccessController = DataAccessController()
    var rightAnswer = Bool()
    var wordIndex = Int()
    
    var segueName = String()
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    
    var selectedGame : Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualizeContainer(fromSegue: segueName)
    }
    
    func visualizeContainer(fromSegue: String){
        containerPlayCards.isHidden = true
        containerCompare.isHidden = true
        containerScore.isHidden = true
        
        switch fromSegue {
        case K.Segues.toPlayCards:
            containerPlayCards.isHidden = false
            lblHeader.text = K.Labels.playCardsHeader
            enableBottomButtons(isEnabled: false)
            
        case K.Segues.toPlayCompare:
            containerCompare.isHidden = false
            lblHeader.text = K.Labels.playCompareHeader
            
            btnHit.setImage(nil, for: .normal)
            btnHit.setTitle(K.Labels.btnTrue, for: .normal)
            btnFail.setImage(nil, for: .normal)
            btnFail.setTitle(K.Labels.btnFalse, for: .normal)
            
        default:
            containerScore.isHidden = false
        }
    }
    
    //Configure this to share info between parent and child
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? PlayCardsController,
           segue.identifier == K.Segues.toPlayCards {
            vc.playCardsDelegate = self
            self.playCardsController = vc
        }
        
        if let vc = segue.destination as? PlayCompareController,
           segue.identifier == K.Segues.toPlayCompare {
            //dataAccessController.dataAccessDelegate = self
            vc.playCompareDelegate = self
            self.playCompareController = vc
        }
    }
    
    
    
    
    fileprivate func thumbAnimation(_ thumbUp: Bool) {
        //When thumb-up pressed call core animation
        view.addSubview(imgAnimationWhenTapButton)
        
        if(thumbUp){
            startPoint = CGPoint(x: 50 , y: view.frame.maxY - 100)
            endPoint = CGPoint(x: 50, y: view.frame.minY)
            imgAnimationWhenTapButton.image = UIImage(systemName: "hand.thumbsup.fill")
            imgAnimationWhenTapButton.tintColor = .green
        } else {
            startPoint = CGPoint(x: view.frame.maxX - 50, y: view.frame.minY + 50)
            endPoint = CGPoint(x: view.frame.maxX - 50, y: view.frame.maxY)
            imgAnimationWhenTapButton.image = UIImage(systemName:"hand.thumbsdown.fill")
            imgAnimationWhenTapButton.tintColor = .red
        }
        
        let duration: Double = 4.0
        let positionAnimation = animationsController.constructPositionAnimation(startingPoint: startPoint, endPoint: endPoint, animationDuration: duration)
        
        imgAnimationWhenTapButton.layer.add(positionAnimation, forKey: "position")
        
        let opacityFadeAnimation = animationsController.constructOpacityAnimation(startingOpacity: 1.0, endingOpacity: 0.0, animationDuration: duration)
        imgAnimationWhenTapButton.layer.add(opacityFadeAnimation, forKey: "opacity")
    }
    
    @IBAction func didGiveAnswer(_ sender: UIButton) {
        enableBottomButtons(isEnabled: false)
        //Configure this to share info between parent and child
        
        if let vc = playCardsController, segueName == K.Segues.toPlayCards {
            vc.lblCardWord.text = ""
            vc.lblPlayCardsFooter.text = K.Labels.playCardsFooterBeforeFlip
            vc.startAnimation(cardImageName: K.Images.cardBack)
            vc.showWordToTranslate()
            //thumbAnimation(sender)
            vc.Update(hit: sender.tag == 0 ? true : false)
            vc.loadScore()
            vc.updateScoreLabels()
            thumbAnimation(sender.tag == 0 ? true : false)
        }
        
        if let vc = playCompareController, segueName == K.Segues.toPlayCompare {           
            var userAnswerWasCorrect = false
            if (sender.tag == 0 && vc.showTrueComparison) || (sender.tag == 1 && !vc.showTrueComparison) {
                userAnswerWasCorrect = true
            }
            let updatedScore = vc.dataAccessController.UpdateScore(hit: userAnswerWasCorrect, game: 1)
            updateScoreLabels(hits: updatedScore.hits, fails: updatedScore.fails)
            vc.createComparison()
            vc.showComparisonCards()
            thumbAnimation(userAnswerWasCorrect)
            Timer.scheduledTimer(withTimeInterval: K.timerDisableButtonsAnswer, repeats: false, block: { [self] _ in
                enableBottomButtons(isEnabled: true)
            
            })
            
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
    
    func updateScoreLabels(hits: Int, fails:Int) {
        lblHits.text = String(hits)
        lblFails.text = String(fails)
    }
}


//MARK: Delegates
extension MasterViewController: PlayCardsDelegate{
    func didUpdateScore(hits: Int, fails: Int) {
        lblHits.text = String(hits)
        lblFails.text = String(fails)
    }

    func didFlipCard(_ playCardsController: PlayCardsController) {
        //lblFooter.text = K.Labels.playCardsFooterAfterFlip
        enableBottomButtons(isEnabled: true)
    }
    
    
    
    func didFailWithError(error: Error) {
        print("This is a messagesDelegate error: \(error)")
    }
}

extension MasterViewController: PlayCompareDelegate{
    func didShowComparison(rightAnswer: Bool, selectedWord: String) {
        dataAccessController.wordIndex = wordIndex
    }
    
    
    func didShowComparison(rightAnswer: Bool, wordIndex: Int) {
        dataAccessController.wordIndex = wordIndex
        self.rightAnswer = rightAnswer
        self.wordIndex = wordIndex
        
    }
    
}
/*
extension MasterViewController: DataAccessDelegate{
    func didUpdateScore1(hits: Int, fails: Int) {
        lblHits.text = String(hits)
        lblFails.text = String(fails)
    }
    
    
}
*/
