//
//  DataAccessController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 1/09/22.
//

import UIKit
import CoreData

class DataAccessController {
    var words = [Word]()
    var score = [Score]()
    var games = [Game]()
    var wordIndex = 0
    var gameIndex = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedWord = String()
    var configurationViewController: ConfigurationViewController?
    var failsOnly = Bool()
    var basicLevel = Bool()
    var intermediateLevel = Bool()
    var advancedLevel = Bool()
    
    init(failsOnly: Bool, basicLevel: Bool, intermediateLevel: Bool, advancedLevel: Bool){
        self.failsOnly = failsOnly
        self.basicLevel = basicLevel
        self.intermediateLevel = intermediateLevel
        self.advancedLevel = advancedLevel
        
        LoadWords()
        LoadScore()
        LoadGames()
    }
    
    func LoadWords() {
        
        var predicates = [NSPredicate]()
        let request : NSFetchRequest<Word> = Word.fetchRequest()
        
        if failsOnly {
            let scoresFails = NSPredicate(format: K.Predicates.scoresFails, 0)
            predicates.append(scoresFails)
        }
        if basicLevel {
            predicates.append(NSPredicate(format: K.Predicates.wordLevel, K.Predicates.basicLevel))
        }
        if intermediateLevel {
            predicates.append(NSPredicate(format: K.Predicates.wordLevel, K.Predicates.intermediateLevel))
        }
        if advancedLevel {
            predicates.append(NSPredicate(format: K.Predicates.wordLevel, K.Predicates.advancedLevel))
        }
        
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        do{
            words = try context.fetch(request)
        } catch {
            print("\(K.Errors.loading) \(error)")
        }
    }
    
    
    func UpdateScore(with request: NSFetchRequest<Score> = Score.fetchRequest(), predicate: NSPredicate? = nil, hit: Bool) {
        
        let wordPredicate = NSPredicate(format: K.Predicates.parentWordEnglish, words[wordIndex].english!)
        let gamePredicate = NSPredicate(format: K.Predicates.parentGame, games[gameIndex].name!)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [wordPredicate, gamePredicate])
        do {
            score = try context.fetch(request)
        } catch {
            print("\(K.Errors.fetching) \(error)")
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
            newScore.parentGame = games[gameIndex]
            newScore.parentWord = words[wordIndex]
            self.score.append(newScore)
        }
        self.saveScore()
        LoadScore()
    }
    
    
    
    func saveScore() {
        do {
            try context.save()
        } catch {
            print("\(K.Errors.saving) \(error)")
        }
    }
    
    
    func LoadGames() {
        let request : NSFetchRequest<Game> = Game.fetchRequest()
        do{
            games = try context.fetch(request)
        } catch {
            print("\(K.Errors.loadingGames) \(error)")
        }
    }
    
    func LoadScore() {
        let request : NSFetchRequest<Score> = Score.fetchRequest()
        do{
            score = try context.fetch(request)
        } catch {
            print("\(K.Errors.loadingScore) \(error)")
        }
    }
}
