//
//  BankTableViewCell.swift
//  BankCounter
//
//  Created by anny on 2020/12/12.
//

import UIKit

class BankTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var processing: UILabel!
    
    @IBOutlet weak var processed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
