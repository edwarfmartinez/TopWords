//
//  ResultsCell.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 21/09/22.
//

import UIKit

class ResultsCell: UITableViewCell {

    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var lblPlayCompareScore: UILabel!
    @IBOutlet weak var lblPlayCardsScore: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblTotalWordHits: UILabel!
    @IBOutlet weak var lblTotalWordFails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
