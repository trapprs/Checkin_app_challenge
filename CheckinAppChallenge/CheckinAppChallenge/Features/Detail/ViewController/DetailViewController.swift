//
//  DetailViewController.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 09/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit
import RxSwift
import MapKit

final class DetailViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextVIew: UITextView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var dateLabeel: UILabel!
    
    private var latitude: Double?
    private var longitude: Double?
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    
    static func instantiate(event: Event) -> DetailViewController {
        guard let viewController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError("Missing expected OnBoarding storyboard content")
        }
        viewController.viewModel.setEvent(event: event)

        return viewController
    }
    @IBAction func openMapDidPress(_ sender: UIButton) {
        guard let latitude = self.latitude,
              let longitude = self.longitude else { return }
        let mapVC = MapViewController.instantiate(latitude: latitude,longitude: longitude)
        mapVC.modalPresentationStyle = .overFullScreen
        
        present(mapVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindValues()
    }

    func bindValues() {
        self.viewModel.title.asObservable().bind(to: titleLabel.rx.text).disposed(by: self.disposeBag)
        self.viewModel.descriptionEvent.asObservable().bind(to: descriptionTextVIew.rx.text).disposed(by: self.disposeBag)
        self.viewModel.image.asObservable().bind(to: self.eventImageView.rx.image).disposed(by: self.disposeBag)
        self.viewModel.date.asObservable().bind(to: self.dateLabeel.rx.text).disposed(by: self.disposeBag)
        
        self.viewModel.people.asObservable().map { optionalEvents -> [People] in
                return optionalEvents ?? []
            }.bind(to: tableView.rx.items(cellIdentifier: "peopleCell", cellType: PeopleTableViewCell.self)) { (index, people, cell) in
                cell.config(people: people)
        }.disposed(by: self.disposeBag)
        
        self.viewModel.latitude.asObservable().subscribe({ [weak self] event in
            guard let strongSelf = self else { return }
            if let latitude = event.element {
                strongSelf.latitude = latitude
            }
        })
        .disposed(by: self.disposeBag)
        
        self.viewModel.longitude.asObservable().subscribe({ [weak self] event in
            guard let strongSelf = self else { return }
            if let longitude = event.element {
                strongSelf.longitude = longitude
            }
        })
        .disposed(by: self.disposeBag)
        

    }
}
