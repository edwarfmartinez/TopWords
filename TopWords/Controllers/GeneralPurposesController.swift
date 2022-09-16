//
//  GeneralPurposesController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 14/09/22.
//

import Foundation
import CoreData
import UIKit

struct GeneralPurposes {
    var dataAccess = DataAccessController()
    var wordIndex = 0
    var choosenWords = [String]()
    var words = [Word]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    mutating func selectWordsToCompare()->[String]{
        wordIndex = Int.random(in: 0..<dataAccess.words.count-1)
        choosenWords[0] = wordIndex % 2 == 0 ? dataAccess.words[wordIndex].english!.capitalizingFirstLetter() :
            dataAccess.words[wordIndex].spanish!.capitalizingFirstLetter()
        
        choosenWords[1] = wordIndex % 2 == 0 ? dataAccess.words[wordIndex].spanish!.capitalizingFirstLetter() :
            dataAccess.words[wordIndex].english!.capitalizingFirstLetter()
        
            return choosenWords
    }
    
    
}
