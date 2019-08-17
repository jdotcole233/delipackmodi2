//
//  HistoryTableViewCell.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 8/6/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var pickUpFromLabel: UILabel!
    @IBOutlet weak var deliverToLabel: UILabel!
    @IBOutlet weak var historyDetailsButton: UIButton! {
        didSet{
            historyDetailsButton.layer.cornerRadius = 8.0
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
