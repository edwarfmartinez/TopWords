//
//  ConfigurationViewController.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 26/09/22.
//

import Foundation
import UIKit

protocol ConfigurationDelegate {
    
    func didChangeOnlyFails(_ value: Bool)
    func didChangeBasic(_ value: Bool)
    func didChangeIntermediate(_ value: Bool)
    func didChangeAdvanced(_ value: Bool)
    func didFailConfigurationDelegate(error: Error)
}

class ConfigurationViewController: UIViewController {
    
    @IBOutlet weak var lblConfigurationTitle: UILabel!
    @IBOutlet weak var lblTrainingSection: UILabel!
    @IBOutlet weak var lblFailsOnly: UILabel!
    @IBOutlet weak var swFailsOnly: UISwitch!
    @IBOutlet weak var lblLevelsSection: UILabel!
    @IBOutlet weak var lblBasicLevel: UILabel!
    @IBOutlet weak var swBasicLevel: UISwitch!
    @IBOutlet weak var lblIntermediateLevel: UILabel!
    @IBOutlet weak var swIntermediateLevel: UISwitch!
    @IBOutlet weak var lblAdvancedLevel: UILabel!
    @IBOutlet weak var swAdvancedLevel: UISwitch!
    
    var configurationDelegate: ConfigurationDelegate?
    var failsOnly = false
    var basicLevel = true
    var intermediateLevel = true
    var advancedLevel = true
    
    override func viewDidLoad() {
        
        lblConfigurationTitle.text = K.Segues.configuration
        lblTrainingSection.text = K.Labels.lblTrainingSection
        lblFailsOnly.text = K.Labels.lblFailsOnly
        lblLevelsSection.text = K.Labels.lblLevelsSection
        lblBasicLevel.text = K.Labels.lblBasicLevel
        lblIntermediateLevel.text = K.Labels.lblIntermediateLevel
        lblAdvancedLevel.text = K.Labels.lblAdvancedLevel        
        
        swFailsOnly.setOn(failsOnly, animated: false)
        swBasicLevel.setOn(basicLevel, animated: false)
        swIntermediateLevel.setOn(intermediateLevel, animated: false)
        swAdvancedLevel.setOn(advancedLevel, animated: false)
    }
    
    @IBAction func swFailsOnlyChanged(_ sender: UISwitch) {
        self.configurationDelegate?.didChangeOnlyFails(swFailsOnly.isOn)
    }
    
    @IBAction func swBasicLevelChanged(_ sender: UISwitch) {
        self.configurationDelegate?.didChangeBasic(swBasicLevel.isOn)
    }
    
    @IBAction func swIntermediateLevelChanged(_ sender: UISwitch) {
        self.configurationDelegate?.didChangeIntermediate(swIntermediateLevel.isOn)
    }
    
    @IBAction func swAdvancedLevelChanged(_ sender: UISwitch) {
        self.configurationDelegate?.didChangeAdvanced(swAdvancedLevel.isOn)
    }
}

class UISwitchCustom: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
    }
}
