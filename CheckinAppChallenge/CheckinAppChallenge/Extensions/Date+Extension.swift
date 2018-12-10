//
//  Date+Extension.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 10/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation


//"dd/MM/yyyy"
extension Date {
   
    
    func dateToShow() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let strDate = dateFormatter.string(from: self)
        return strDate
    }
    
   
}
