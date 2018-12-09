//
//  ListItemsViewController.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 09/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ListItemsViewController: UIViewController {
    let listItemsViewModel: ListItemsViewModel = ListItemsViewModel()
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadValues()
    }
    
    func loadValues() {
        self.listItemsViewModel.getEvents(url: "\(serverLink)/events")
        
        self.listItemsViewModel.events.asObservable().map { optionalEvents -> [Event] in
                return optionalEvents ?? []
            }.bind(to: tableView.rx.items(cellIdentifier: "cellEventList", cellType: ListEventTableViewCell.self)) { (index, event, cell) in
                cell.config(event: event)
            }.disposed(by: disposeBag)
    }
}
