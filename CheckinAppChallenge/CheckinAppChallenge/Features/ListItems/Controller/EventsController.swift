//
//  EventsController.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 09/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation

class EventsController {
    typealias CompletionRequestAPI = (Bool, [Event]?, Error?) -> Void

    func getListOfEvents(url: String, completion: @escaping CompletionRequestAPI){
        Service.request(url: url) { (result) in
            print(url)
            switch result {
                
            case .success(let data):
                do {
                    let events = try JSONDecoder().decode([Event].self, from: data)
                    completion(true, events, nil)
                } catch(let error) {
                    completion(true, nil, error)
                }
            case .failure(let error):
                completion(false,nil,error)
            }
        }
    }
}
