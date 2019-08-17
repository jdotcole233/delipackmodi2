//
//  ProfileController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/17/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    
    @IBOutlet weak var customerFullName: UILabel!
    
    @IBOutlet weak var customerSubEmail: UIStackView!
    @IBOutlet weak var customerPhoneNumber: UILabel!
    @IBOutlet weak var customerEmail: UILabel!
    
    
    @IBAction func tellAfriendButton(_ sender: Any) {
        let tellAfriendBtn = UIActivityViewController(activityItems: ["Charley tell a friend about deli Pack"], applicationActivities: nil)
            tellAfriendBtn.popoverPresentationController?.sourceView = self.view
            present(tellAfriendBtn, animated: true, completion: nil)
        tellAfriendBtn.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
            
            if completed {
//                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customerDetails = UserDefaults.standard.value(forKey: "customerLoggedin") as? [String:Any] ?? [:]
        customerFullName.text = "\(String(describing: customerDetails["first_name"].unsafelyUnwrapped))  \(String(describing:customerDetails["last_name"].unsafelyUnwrapped))"
        customerPhoneNumber.text = "\(String(describing: customerDetails["phone_number"].unsafelyUnwrapped))"
        
        
        

        // Do any additional setup after loading the view.
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
