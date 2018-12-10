//
//  DetailViewModel.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 10/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel {
    let title = BehaviorRelay<String?>(value: nil)
    let descriptionEvent = BehaviorRelay<String?>(value: nil)
    let people = BehaviorRelay<[People]?>(value: nil)
    let image = BehaviorRelay<UIImage?>(value: nil)
    let date = BehaviorRelay<String?>(value: nil)
    let latitude = BehaviorRelay<Double?>(value: nil)
    let longitude = BehaviorRelay<Double?>(value: nil)
    
    func setEvent(event: Event? = nil) {
        guard let event = event else {
            return
        }
        
        title.accept(event.title)
        descriptionEvent.accept(event.description)
        people.accept(event.people)
      
        let dateSaved = Date(timeIntervalSince1970: TimeInterval(exactly: (event.date) / 1000) ?? 0).dateToShow()
        date.accept(dateSaved)
        
        latitude.accept(event.latitude)
        longitude.accept(event.longitude)
        
        Service.requestImage(url: "\(event.image)") { [weak self] (result) in
            DispatchQueue.global(qos: .userInitiated).async {
                guard let strongSelf = self else { return }
               
                DispatchQueue.main.async {
                    if let image = result.value {
                        strongSelf.image.accept(image)
                    }
                }
                
            }
        }
    }
}
