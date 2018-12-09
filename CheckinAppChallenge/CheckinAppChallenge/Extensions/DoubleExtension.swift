//
//  DoubleExtension.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 09/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation

extension Double {
    func formatCurrency(prefixMessage:String?=nil, sufixMessage:String?=nil) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        guard var fullMessage = formatter.string(from: NSNumber(value: self)) as String? else {
            return ""
        }
        
        if let prefix : String = prefixMessage {
            fullMessage = prefix + fullMessage
        }
        if let sufix : String = sufixMessage {
            fullMessage = (fullMessage + sufix)
        }
        
        return fullMessage
    }
}
