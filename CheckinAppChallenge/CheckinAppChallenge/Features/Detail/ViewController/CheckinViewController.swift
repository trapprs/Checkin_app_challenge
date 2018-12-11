//
//  CheckinViewController.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 11/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit
import Eureka

class CheckinViewController: FormViewController {
    
    static func instantiate() -> CheckinViewController {
        guard let viewController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "CheckinViewController") as? CheckinViewController else {
            fatalError("Missing expected OnBoarding storyboard content")
        }
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Dados Pessoais")
            <<< TextRow(){ row in
                row.title = "nome"
                row.placeholder = "Informe seu nome"
            }
            <<< TextRow() {
                $0.title = "Email"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleEmail())
                $0.validationOptions = .validatesOnChangeAfterBlurred
                
            }
            +++ Section()
            <<< ButtonRow() {
                $0.title = "Confirmar"
                
            }
        
    }
}
