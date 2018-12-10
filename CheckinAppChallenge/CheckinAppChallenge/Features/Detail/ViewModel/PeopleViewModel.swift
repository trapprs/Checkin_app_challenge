//
//  PeopleViewModel.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 10/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit
import RxCocoa

final class PeopleViewModel {
    let name = BehaviorRelay<String?>(value: nil)
    let image = BehaviorRelay<UIImage?>(value: nil)
    
    func setPeople(people: People? = nil) {
        guard let people = people else {
            return
        }
        
        name.accept(people.name)
        Service.requestImage(url: "\(people.picture)") { [weak self] (result) in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
            
                if let image = result.value {
                    strongSelf.image.accept(image)
                }
            }
        }
    }
}
