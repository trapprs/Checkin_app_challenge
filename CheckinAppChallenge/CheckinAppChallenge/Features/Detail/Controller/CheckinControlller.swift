//
//  CheckinControlller.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 11/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation

final class CheckinControlller {
    typealias CompletionRequestAPI = (Bool, Error?) -> Void
    
    func checkinToEvent(url: String, eventId: String, name:String, email: String, completion: @escaping CompletionRequestAPI){
        let params = ["name"    : name,
                      "eventId" : eventId,
                      "email"   : email] as [String: Any]
        
        Service.request(url: url, params: params) { (result) in
            switch result {
            case .success:
                print(result)
                completion(true, nil)
            case .failure(let error):
                completion(true, error)
            }
        }
    }
}
