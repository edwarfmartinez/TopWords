//
//  ScoreViewController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataAccessController = DataAccessController(failsOnly: false, basicLevel: true, intermediateLevel: true, advancedLevel: true)
    var scoreResults : [ScoreResult] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        prepareData()
    }
    
    func prepareData() {
        
        let dictionaryScoreResults = Dictionary(grouping: dataAccessController.score) { (word) -> String? in
            return (word.parentWord?.spanish?.capitalizingFirstLetter())! + " / " + (word.parentWord?.english?.capitalizingFirstLetter())!
        }
        scoreResults = dictionaryScoreResults.map({
            let scoreResult = ScoreResult(word: "", totalScore: 0, playCardsHits: 0, playCardsFails: 0, playCompareHits: 0, playCompareFails: 0)
            
            scoreResult.word = $0.key!
            scoreResult.playCompareHits = Int($0.value.first{$0.parentGame?.name == K.Segues.playCompare}?.hits ?? 0)
            scoreResult.playCompareFails = Int($0.value.first{$0.parentGame?.name == K.Segues.playCompare}?.fails ?? 0)
            scoreResult.playCardsHits = Int($0.value.first{$0.parentGame?.name == K.Segues.playCards}?.hits ?? 0)
            scoreResult.playCardsFails = Int($0.value.first{$0.parentGame?.name == K.Segues.playCards}?.fails ?? 0)
            scoreResult.totalScore = scoreResult.playCompareHits + scoreResult.playCardsHits -
            scoreResult.playCompareFails - scoreResult.playCardsFails
            
            return scoreResult
        })    
        sortScoreResults(byHits: true)
    }
    
    func sortScoreResults(byHits:Bool){        
        scoreResults = byHits ? scoreResults.sorted(by: { $0.totalScore > $1.totalScore }) : scoreResults.sorted(by: { $0.totalScore < $1.totalScore })
        self.tableView.reloadData()
    }
    
    func loadMessages() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let indexPath =  IndexPath(row: self.scoreResults.count-1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}

extension ScoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.scoreResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = self.scoreResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! ResultsCell
                
        cell.lblWord.text = message.word
        cell.lblPlayCardsScore.text = String(message.playCardsHits) + K.separator + String(message.playCardsFails)
        cell.lblPlayCompareScore.text = String(message.playCompareHits) + K.separator + String(message.playCompareFails)
        cell.lblTotalWordHits.text = String(Int(message.playCardsHits) + Int(message.playCompareHits))
        cell.lblTotalWordFails.text = String(Int(message.playCardsFails) + Int(message.playCompareFails))
        cell.lblScore.text = String(message.totalScore)
        
        return cell
    }
}
