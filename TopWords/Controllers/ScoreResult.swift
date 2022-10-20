//
//  ScoreResult.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 19/10/22.
//

//import Foundation

class ScoreResult {
    var word: String
    var totalScore: Int
    var playCardsHits: Int
    var playCardsFails: Int
    var playCompareHits: Int
    var playCompareFails: Int
    
    init(word: String, totalScore: Int, playCardsHits: Int, playCardsFails: Int, playCompareHits: Int, playCompareFails: Int) {
        
        self.word = word
        self.totalScore = totalScore
        self.playCardsHits = playCardsHits
        self.playCardsFails = playCardsFails
        self.playCompareHits = playCompareHits
        self.playCompareFails = playCompareFails
    }
    
}
