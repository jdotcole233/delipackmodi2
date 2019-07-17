//
//  FindingRiderModalController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/17/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class FindingRiderModalController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = .clear

        // Do any additional setup after loading the view.
    }
    

    @IBAction func endRiderSearchBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
