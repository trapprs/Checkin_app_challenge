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
    
    func config(event: Event?) {
        guard let event = event else { return }
       
        self.event = event
        
        self.eventNameLabel.text = "\(event.title)"
        self.priceEventLabel.text = "\(event.price.formatCurrency())"
    }
}
