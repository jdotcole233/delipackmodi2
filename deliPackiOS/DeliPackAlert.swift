//
//  DeliPackAlert.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/27/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import Foundation
import UIKit

class DeliPackAlert {
    
    let alertTitle: String
    let alertMessage: String
    let context: UIViewController
    
    init(context: UIViewController, alertTitle: String, alertMessage: String) {
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.context = context
    }
    
    func showAlet() {
        let alertDisplay = UIAlertController.init(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertDisplay.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            switch UIAlertAction.style{
            case .default:
                    print("Default")
            case .cancel:
                    print("cancel")
            case .destructive:
                    print("Destructive")
                
            }
        }))
        context.present(alertDisplay, animated: true, completion: nil)
    }
    
}
