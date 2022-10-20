//
//  Constants.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 30/08/22.
//

import UIKit

struct K {
    
    static let appName = "Top Words"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "ResultsCell"
    static let separator = " / "
    static let timerDisableButtonsAnswer = 2.0
    
    struct Segues{
        
        static let playCards =  "Play Cards"
        static let playCompare = "Play Compare"
        static let checkScore = "Score"
        static let configuration = "Configuration"
    }
    
    struct Labels{
        
        static let playCardsHeader = "Mentally translate the word\nMentalmente traduce la palabra:"
        static let playCardsMiddle = "Translates\nTraduce"
        static let playCardsFooterBeforeFlip = "Tap the card to check...\nToca la carta para verificar..."
        static let playCardsFooterAfterFlip = "Did you get it right?\nAcertaste?"
        
        static let playCompareHeader = "Answer 'True' of 'False'\nResponde 'Verdadero' o 'Falso':"
        static let btnTrue = "True"
        static let btnFalse = "False"
        static let btnConfiguration = "Configuration"
        static let scoreHeader = "Check your relevant hits and fails"
        static let btnScoreHits = "Top Hits"
        static let btnScoreFails = "Top Fails"
        
        // Configuration
        //static let lblConfigurationTitle = "Configuration"
        static let lblTrainingSection = "Fails Training"
        static let lblFailsOnly = "Train only my fails"
        static let lblLevelsSection = "Levels of training"
        static let lblBasicLevel = "Train basic words"
        static let lblIntermediateLevel = "Train intermediate words"
        static let lblAdvancedLevel = "Train advanced words"
        
        //Menu
        static let lblPokerDescription = "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."
        static let lblCompareDescription = "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."
        static let lblScoreDescription = "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."
        static let lblConfigurationDescription = "Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."
                
    }
    struct Colors{
        static let disabledAplha = 0.3
        static let enabledAplha = 1.0
    }
    struct Images{
        static let cardBack = "cardTopWordsBack"
        static let cardFront = "cardTopWordsFront"
    }
    struct Animations{
        
        static let pointShort = 30.0
        static let pointLarge = 150.0
        static let cardFlipTimer = 0.4
        static let initialSpringVelocity = 0.5
        static let usingSpringWithDamping1 = 1.0
        static let usingSpringWithDamping075 = 0.75
        static let usingSpringWithDamping05 = 0.5
        static let duration = 1.0
        static let duration05 = 0.5
        
        //Score animation
        struct Score {
            static let pointShort = 50.0
            static let pointLarge = 100.0
            static let hitIcon = "hand.thumbsup.fill"
            static let hitIconColor = UIColor.green
            static let failIcon = "hand.thumbsdown.fill"
            static let failIconColor = UIColor.red
            static let animationDuration = 4.0
            static let startingOpacity = 1.0
            static let positionKey = "position"
            static let opacityKey = "opacity"
        }
        
    }
    struct Predicates {
        static let parentWordEnglish = "parentWord.english MATCHES %@"
        static let parentGame = "parentGame.name MATCHES %@"
        static let scoresFails = "ANY scores.fails > 0"
        static let wordLevel = "level CONTAINS %@"
        
        static let basicLevel = "A"
        //static let basicLevel = ["A","B","C"]
        static let intermediateLevel = "B"
        static let advancedLevel = "C"
    }
    struct Errors {
        static let fetching = "Error fetching Data: "
        static let saving = "Error saving Data: "
        static let loading = "Error loading Data: "
        static let loadingGames = "Error loading Games: "
        static let loadingScore = "Error loading Score: "
        static let didFailConfigurationDelegate = "This is a didFailConfigurationDelegate error: "
        static let playCardsDelegate = "This is a PlayCardsDelegate error: "
        
    }
    
    struct Tests{
        
        static let totalWords =  3000
        static let totalBasicWords = 1699
        static let totalIntermediateWords = 1494
        static let totalAdvancedWords = 1
    }
    
}
