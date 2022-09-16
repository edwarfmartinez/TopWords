//
//  PlayCardsController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 30/08/22.
//

import UIKit
import CoreData

protocol PlayCardsDelegate {
    func didFlipCard(_ playCardsController: PlayCardsController)
    func didUpdateScore(hits: Int, fails: Int)
    func didFailWithError(error: Error)
}

class PlayCardsController: UIViewController {
    
    @IBOutlet weak var lblAskedWord: UILabel!
    @IBOutlet weak var btnCard: UIButton!
    @IBOutlet weak var lblCardWord: UILabel!
    @IBOutlet weak var viewAskedWord: UIView!
    @IBOutlet weak var lblPlayCardsFooter: UILabel!
    
    var animationsController = AnimationsController()
    var playCardsDelegate: PlayCardsDelegate?
    var dataAccessController = DataAccessController()
    
    var isOpen = false
    var words = [Word]()
    var score = [Score]()
    var games = [Game]()
    var selectedGame : Game?
    
    var wordAsked: String = ""
    var wordForCard: String = ""
    var wordIndex: Int = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // DB path
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        btnCard.imageView!.contentMode = .scaleAspectFit
        lblPlayCardsFooter.text = K.Labels.playCardsFooterBeforeFlip
        self.lblAskedWord.alpha = 0
        
        //dataAccessController.loadWords()
        //dataAccessController.loadGames()
        loadGames()
        loadWords()
        loadScore()
        updateScoreLabels()
        chooseRandomWord()
        showWordToTranslate()
        
    }
    
    func loadGames() {
        let request : NSFetchRequest<Game> = Game.fetchRequest()
        do{
            games = try context.fetch(request)
        } catch {
            print("Error loading games: \(error)")
        }
    }
    
    func loadScore() {
        let request : NSFetchRequest<Score> = Score.fetchRequest()
        do{
            score = try context.fetch(request)
        } catch {
            print("Error loading score: \(error)")
        }
    }
    
    func loadWords() {
        let request : NSFetchRequest<Word> = Word.fetchRequest()
        do{
            words = try context.fetch(request)
        } catch {
            print("Error loading words: \(error)")
        }
    }
    
    func Update(with request: NSFetchRequest<Score> = Score.fetchRequest(), predicate: NSPredicate? = nil, hit: Bool) {
        
        let wordPredicate = NSPredicate(format: "parentWord.english MATCHES %@", words[wordIndex].english!)
        let gamePredicate = NSPredicate(format: "parentGame.name MATCHES %@", games[0].name!)
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [wordPredicate, gamePredicate])
        
        do {
            score = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        if score.count > 0 {
            if hit {
                score.first?.hits += 1
            } else {
                score.first?.fails += 1
            }
        } else {
            let newScore = Score(context: self.context)
            if hit {
                newScore.hits += 1
            } else {
                newScore.fails += 1
            }
            newScore.parentGame = games[0]
            newScore.parentWord = words[wordIndex]
            self.score.append(newScore)
        }
        self.saveScore()
        
    }
    
    func updateScoreLabels() {
        
        self.playCardsDelegate?.didUpdateScore(hits: score.reduce(0) { $0 + Int($1.hits) }, fails: score.reduce(0) { $0 + Int($1.fails) })
    }
    
    func saveScore() {
        do {
            try context.save()
        } catch {
            print("Error saving score: \(error)")
        }
    }
    
    
    func chooseRandomWord() {
        lblCardWord.isHidden = true
        wordIndex = Int.random(in: 0..<words.count-1)
        guard wordIndex % 2 == 0 else {
            lblAskedWord.text = words[wordIndex].english!.capitalizingFirstLetter()
            lblCardWord.text = words[wordIndex].spanish!.capitalizingFirstLetter()
            return
        }
        lblAskedWord.text = words[wordIndex].spanish!.capitalizingFirstLetter()
        lblCardWord.text = words[wordIndex].english!.capitalizingFirstLetter()
        
    }
    
    
    func disappearWordToTranslate() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.lblAskedWord.alpha = 0
            self.lblAskedWord.transform = CGAffineTransform(translationX: 30, y: -150)
        }) { (_) in
        }
    }
    
    func showWordToTranslate() {
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.lblAskedWord.alpha = 0
            self.lblAskedWord.transform = CGAffineTransform(translationX: 0, y: -150)
        })
        { (_) in
            UIView.animate(withDuration: 0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.lblAskedWord.transform = CGAffineTransform(translationX: -30, y: -150)
                //self.lblCardWord.isHidden=false
                self.chooseRandomWord()
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
    
    @IBAction func btnShowCardFront(_ sender: UIButton) {
        if !isOpen{
            lblPlayCardsFooter.text = K.Labels.playCardsFooterAfterFlip
            startAnimation(cardImageName: K.Images.cardFront)
            self.playCardsDelegate?.didFlipCard(self)
        }
    }
    
    func startAnimation(cardImageName: String){
        lblCardWord.isHidden = false
        let image = UIImage(named: cardImageName)
        btnCard.setImage(image, for: .normal)
        performTransition(elementToAnimate: btnCard)
        performTransition(elementToAnimate: lblCardWord)
        performTransition(elementToAnimate: lblPlayCardsFooter)
        isOpen = cardImageName == K.Images.cardFront ? true : false
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

