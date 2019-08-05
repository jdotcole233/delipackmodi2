//
//  ViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/15/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        signInButton.layer.cornerRadius = CGFloat(Int(bitPattern: 8))
        registerButton.layer.cornerRadius = CGFloat(Int(bitPattern: 8))
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough"){
            return
        }
        
        let storyboard = UIStoryboard(name: "WelcomeWalkthrough", bundle: nil)
        if let startWalkthroughViewController = storyboard.instantiateViewController(withIdentifier: "walkthroughviewcontroller")
            as? WalkThroughViewController
        {
            present(startWalkthroughViewController, animated: true, completion: nil)
        }
    }

}

