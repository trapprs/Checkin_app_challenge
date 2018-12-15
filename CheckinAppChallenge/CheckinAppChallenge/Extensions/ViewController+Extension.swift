//
//  ViewController+Extension.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 11/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit

extension UIViewController {
    func showsAlert(_ msg: String, back: Bool? = false) {
        let alert = UIAlertController(title: "Aviso", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .`default`, handler: { _ in
            if back! {
                if let navigation = self.navigationController {
                    navigation.popToRootViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
