//
//  ScoreCell.swift
//  TopWords
//
//  Created by EDWAR FERNANDO MARTINEZ CASTRO on 29/08/22.
//

import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var lblHits: UILabel!
    @IBOutlet weak var lblFails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
