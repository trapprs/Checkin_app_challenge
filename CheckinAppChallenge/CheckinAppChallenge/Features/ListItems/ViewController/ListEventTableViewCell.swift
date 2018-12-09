//
//  ListEventTableViewCell.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 09/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit

class ListEventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var priceEventLabel: UILabel!
    var event: Event?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(event: Event) {
        self.event = event
        
        self.eventNameLabel.text = "\(event.title)"
        self.priceEventLabel.text = "\(event.price.formatCurrency())"
    }
}
