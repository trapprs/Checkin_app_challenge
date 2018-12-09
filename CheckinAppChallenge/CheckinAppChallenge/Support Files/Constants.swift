//
//  Constants.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 09/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation

private let configServerJson: [String: Any]? = {
    guard
        let path = Bundle.main.path(forResource: "Server", ofType: "plist"),
        let dicInfo = NSDictionary(contentsOfFile: path),
        let dicConfig = dicInfo["Configuration"] as? [String: Any]
        else { return nil }
    
    return dicConfig
}()

var serverLink: String = {
    guard
        let urlBase = configServerJson?["serverLink"] as? String
        else { return "" }
    
    return urlBase
}()
