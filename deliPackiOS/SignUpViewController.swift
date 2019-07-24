//
//  SignUpViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/24/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signUpButton.layer.cornerRadius = CGFloat(Int(bitPattern: 8))
     
        view.addGestureRecognizer(UIGestureRecognizer(target: view, action: #selector(self.hideKeyBoard)))
        
    }
    
    

    @objc func hideKeyBoard(){
        view.endEditing(false)
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
