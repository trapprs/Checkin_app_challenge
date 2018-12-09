//
//  ListItemsViewModel.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 09/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ListItemsViewModel {
    let events = BehaviorRelay<[Event]?>(value: nil)
    let controller = EventsController()
   
    let error = BehaviorRelay<Error?>(value: nil)
   
    func getEvents(url: String) {
        controller.getListOfEvents(url: url) { [unowned self] (success, events, error) in
            if success {
                self.events.accept(events)
            } else {
                self.error.accept(error)
            }
        }
    }
    
}
