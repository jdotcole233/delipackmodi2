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
    var alertDisplay: UIAlertController?
    
    
    
    init(context: UIViewController, alertTitle: String, alertMessage: String) {
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.context = context
        alertDisplay = UIAlertController.init(title: alertTitle, message: alertMessage, preferredStyle: .alert)

    }
    
    func showAlet() {
        alertDisplay!.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            switch UIAlertAction.style{
            case .default:
                    print("Default")
            case .cancel:
                    print("cancel")
            case .destructive:
                    print("Destructive")
                
            }
        }))
        context.present(alertDisplay!, animated: true, completion: nil)
    }
    
    func showLoaderAlert (){
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        guard alertDisplay == nil else {
            return
        }
        alertDisplay!.view.addSubview(loadingIndicator)
        context.present(alertDisplay!, animated: true, completion: nil)
    }
    
    func hideLoaderAler() {
        context.dismiss(animated: false, completion: nil)
    }
    
}
