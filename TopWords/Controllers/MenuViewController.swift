//
//  MenuViewController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {
    
    @IBOutlet weak var btnPlayCards: UIButton!
    @IBOutlet weak var btnPlayCompare: UIButton!
    @IBOutlet weak var btnCheckScore: UIButton!
    @IBOutlet weak var btnConfiguration: UIButton!    
    @IBOutlet weak var lblPokerTitle: UILabel!
    @IBOutlet weak var lblPokerDescription: UILabel!
    @IBOutlet weak var lblCompareTitle: UILabel!
    @IBOutlet weak var lblCompareDescription: UILabel!    
    @IBOutlet weak var lblScoreTitle: UILabel!
    @IBOutlet weak var lblScoreDescription: UILabel!
    @IBOutlet weak var lblConfigurationTitle: UILabel!
    @IBOutlet weak var lblConfigurationDescription: UILabel!
    
    var gameIndex = 0
    var failsOnly = false
    var basicLevel = true
    var intermediateLevel = true
    var advancedLevel = true
           
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        lblPokerTitle.text = K.Segues.playCards
        lblPokerDescription.text = K.Labels.lblPokerDescription
        lblCompareTitle.text = K.Segues.playCompare
        lblCompareDescription.text = K.Labels.lblCompareDescription
        lblScoreTitle.text = K.Segues.checkScore
        lblScoreDescription.text = K.Labels.lblScoreDescription
        lblConfigurationTitle.text = K.Segues.configuration
        lblConfigurationDescription.text = K.Labels.lblConfigurationDescription
        
        let dataAccessController = DataAccessController(failsOnly: failsOnly, basicLevel: basicLevel, intermediateLevel: intermediateLevel, advancedLevel: advancedLevel)
        dataAccessController.LoadGames()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        
        guard segue.identifier == K.Segues.configuration else {
            let destVC = segue.destination as! MasterViewController
            destVC.segueName = segue.identifier!
            destVC.failsOnly = failsOnly
            destVC.basicLevel = basicLevel
            destVC.intermediateLevel = intermediateLevel
            destVC.advancedLevel = advancedLevel
            if let buttonItem = sender as? UIButton{
                destVC.gameIndex = buttonItem.tag
            }
            return
        }
        
        let vc = segue.destination as? ConfigurationViewController
        vc!.configurationDelegate = self
        vc!.failsOnly = failsOnly
        vc!.basicLevel = basicLevel
        vc!.intermediateLevel = intermediateLevel
        vc!.advancedLevel = advancedLevel
    }
}

extension MenuViewController: ConfigurationDelegate {
    
    func didChangeBasic(_ value: Bool) {
        basicLevel = value
    }
    
    func didChangeIntermediate(_ value: Bool) {
        intermediateLevel = value
    }
    
    func didChangeAdvanced(_ value: Bool) {
        advancedLevel = value
    }
    
    func didChangeOnlyFails(_ value: Bool) {
        failsOnly = value
    }
    
    func didFailConfigurationDelegate(error: Error) {
        print("\(K.Errors.didFailConfigurationDelegate) \(error)")
    }
        
}
