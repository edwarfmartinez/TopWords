//
//  yellowController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 1/09/22.
//

import UIKit
import CoreData

/*
protocol DataAccessDelegate {
    func didUpdateScore1(hits: Int, fails: Int)
    func didFailWithError(error: Error)
}
 */
class DataAccessController {
    var words = [Word]()
    var score = [Score]()
    var games = [Game]()
    var wordIndex = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedWord = String()
    
    //var dataAccessDelegate: DataAccessDelegate?
    
    func UpdateScore(with request: NSFetchRequest<Score> = Score.fetchRequest(), predicate: NSPredicate? = nil, hit: Bool, game: Int)->(hits: Int, fails: Int) {
        
        print("DataAccessController - dataAccess.wordIndex: \(wordIndex)")
        
        let wordPredicate = NSPredicate(format: "parentWord.english MATCHES %@", words[wordIndex].english!)
        
        let gamePredicate = NSPredicate(format: "parentGame.name MATCHES %@", games[game].name!)
        
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
        loadScore()
        print("score.count: \(score.count)")
       // self.dataAccessDelegate?.didUpdateScore1(hits: score.reduce(0) { $0 + Int($1.hits) }, fails: score.reduce(0) { $0 + Int($1.fails) })
   return (hits: score.reduce(0) { $0 + Int($1.hits) }, fails: score.reduce(0) { $0 + Int($1.fails) })
    }
    
    func saveScore() {
        do {
            try context.save()
        } catch {
            print("Error saving score: \(error)")
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
    
    
    
}
