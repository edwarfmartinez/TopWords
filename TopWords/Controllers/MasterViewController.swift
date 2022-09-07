//
//  MasterViewController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 31/08/22.
//

import Foundation
import UIKit

class MasterViewController: UIViewController{
    
    @IBOutlet weak var containerPlayCards: UIView!
    @IBOutlet weak var containerCompare: UIView!
    @IBOutlet weak var containerScore: UIView!
    @IBOutlet weak var btnHit: UIButton!
    @IBOutlet weak var btnFail: UIButton!
    @IBOutlet weak var imgAnswerAnimation: UIImageView!
    
    var animationsController = AnimationsController()
    var segueName = String()
    var playCardsController : PlayCardsController?
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualizeContainer(fromSegue: segueName)
    }
    
    //Configure this to share info between parent and child
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlayCardsController,
           segue.identifier == K.Segues.toPlayCards {
            vc.playCardsDelegate = self
            self.playCardsController = vc
        }
    }
    
    func visualizeContainer(fromSegue: String){
        containerPlayCards.isHidden = true
        containerCompare.isHidden = true
        containerScore.isHidden = true
        
        switch fromSegue {
        case K.Segues.toPlayCards:
            containerPlayCards.isHidden = false
            enableBottomButtons(isEnabled: false)
        case K.Segues.toPlayCompare:
            containerCompare.isHidden = false
        default:
            containerScore.isHidden = false
        }
    }
    
    @IBAction func didGiveAnswer(_ sender: UIButton) {
        enableBottomButtons(isEnabled: false)
        //Configure this to share info between parent and child
        if let vc = playCardsController {
            vc.lblTranslatedWord.text = ""
            vc.lblPlayCardsBottom.text = K.Labels.playCardsBottomBeforeFlip
            vc.startAnimation(cardImageName: K.Images.cardBack)
            vc.showWordToTranslate()
            
        }
        
        //When thumb-up pressed call core animation
        view.addSubview(imgAnswerAnimation)
         
        if(btnHit.tag == sender.tag){
            startPoint = CGPoint(x: 50 , y: view.frame.maxY - 100)
            endPoint = CGPoint(x: 50, y: view.frame.minY)
            imgAnswerAnimation.image = UIImage(systemName: "hand.thumbsup.fill")
            imgAnswerAnimation.tintColor = .green
        } else {
            startPoint = CGPoint(x: view.frame.maxX - 50, y: view.frame.minY + 50)
            endPoint = CGPoint(x: view.frame.maxX - 50, y: view.frame.maxY)
            imgAnswerAnimation.image = UIImage(systemName:"hand.thumbsdown.fill")
            imgAnswerAnimation.tintColor = .red
        }
        
        let duration: Double = 1.0
        let positionAnimation = animationsController.constructPositionAnimation(startingPoint: startPoint, endPoint: endPoint, animationDuration: duration)
        
        imgAnswerAnimation.layer.add(positionAnimation, forKey: "position")
        
        let opacityFadeAnimation = animationsController.constructOpacityAnimation(startingOpacity: 1.0, endingOpacity: 0.0, animationDuration: duration)
        imgAnswerAnimation.layer.add(opacityFadeAnimation, forKey: "opacity")
    }
    
    func enableBottomButtons(isEnabled: Bool) {
        btnHit.isEnabled = isEnabled
        btnFail.isEnabled = isEnabled
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: Delegates
extension MasterViewController: PlayCardsDelegate{
    func didFlipCard(_ playCardsController: PlayCardsController) {
        enableBottomButtons(isEnabled: true)
    }
    func didFailWithError(error: Error) {
        print("This is a messagesDelegate error: \(error)")
    }
}
