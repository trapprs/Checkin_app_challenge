//
//  PeopleTableViewCell.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 10/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit
import RxSwift

final class PeopleTableViewCell: UITableViewCell {
    var viewModel = PeopleViewModel()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var peopleImageView: UIImageView!{
        didSet {
            peopleImageView.layer.cornerRadius = 20   
        }
    }
    var disposeBag = DisposeBag()
    
    func config(people: People) {
        viewModel.setPeople(people: people)
        viewModel.name.asObservable().bind(to: nameLabel.rx.text).disposed(by: self.disposeBag)
        DispatchQueue.main.async {
            self.viewModel.image.asObservable().bind(to: self.peopleImageView.rx.image).disposed(by: self.disposeBag)
        }
    }
}
