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
        static let playCardsTop = "Translate the word:"
        static let playCardsBottomBeforeFlip = "Touch card to check..."
        static let playCardsBottomAfterFlip = "Did you hit?"
    }
    
    struct Colors{
        static let disabledAplha = 0.3
        static let enabledAplha = 1.0
    }
   
    struct Images{
        static let cardBack = "CardTopWordsBack"
        static let cardFront = "CardTopWordsFront"
    }
    
    static let cardFlipTimer = 0.6
    
}
