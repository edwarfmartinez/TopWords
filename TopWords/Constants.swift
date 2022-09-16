//
//  Constants.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 30/08/22.
//

import UIKit

struct K {
    
    struct Segues{
        static let toPlayCards =  "toPlayCards"
        static let toPlayCompare = "toPlayCompare"
        static let toCheckScore = "toCheckScore"
    }
    struct Labels{
        static let playCardsHeader = "Mentally translate the word\nMentalmente traduce la palabra:"
        static let playCardsMiddle = "Translates/\nTraduce"
        static let playCardsFooterBeforeFlip = "Tap the card to check.../\nToca la carta para verificar..."
        static let playCardsFooterAfterFlip = "Did you get it right?/\nAcertaste?"
        
        static let playCompareHeader = "Answer 'True' of 'False'\nResponde 'Verdadero' o 'Falso':"
        static let btnTrue = "True"
        static let btnFalse = "False"
    }
    
    struct Colors{
        static let disabledAplha = 0.3
        static let enabledAplha = 1.0
    }
   
    struct Images{
        static let cardBack = "CardTopWordsBack"
        static let cardFront = "CardTopWordsFront"
    }
    
    struct Animations{
        static let pointShort = 30.0
        static let pointLarge = 150.0
        static let cardFlipTimer = 0.4
    }
    
    static let timerDisableButtonsAnswer = 2.0
    
    
}
