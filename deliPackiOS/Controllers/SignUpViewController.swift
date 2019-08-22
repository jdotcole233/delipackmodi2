//
//  SignUpViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/24/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit
// import Ringcaptcha

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum HistoryResult<T> {
    case History_success([T])
    case failure(Error)
}


class SignUpViewController: UIViewController {

    
    @IBOutlet weak var signUpButton: UIButton!
    
    //Register customer text field outlet
    @IBOutlet weak var customerFirstName: UITextField!
    @IBOutlet weak var customerLastName: UITextField!
    @IBOutlet weak var customerEmail: UITextField!
    @IBOutlet weak var customerPassword: UITextField!
    @IBOutlet weak var customerConfirmPassword: UITextField!
    //End of register customer text field outlets
    var delipackalert: DeliPackAlert?
    var networkService: NetworkService?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customerPassword.isSecureTextEntry = true
        customerConfirmPassword.isSecureTextEntry = true
        networkService = NetworkService()
        // Do any additional setup after loading the view.
        signUpButton.layer.cornerRadius = CGFloat(Int(bitPattern: 8))
        let viewtapped = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(viewtapped)
        
    }

    // Register customer button click event
    @IBAction func signUpButtonOnClick(_ sender: Any) {
        let firstName = customerFirstName.text!
        let lastName = customerLastName.text!
        let email = customerEmail.text!
        let firstPassword = customerPassword.text!
        let confirmFirstPassword = customerConfirmPassword.text!
        
        if firstName.isEmpty || lastName.isEmpty || firstPassword.isEmpty || confirmFirstPassword.isEmpty{
            print("All fields are mandatory!")
            delipackalert = DeliPackAlert(context: self,alertTitle: "Mandatory fields", alertMessage: "All fields must be field before you can be registered")
            delipackalert!.showAlet()
            return
        } else {
            if firstPassword.count < 8 {
                DeliPackAlert(context: self, alertTitle: "Password Count", alertMessage: "password must be more than 8 characters").showAlet()
                return
            } else {
                if firstPassword != confirmFirstPassword {
                    DeliPackAlert(context: self, alertTitle: "Password Mismatch", alertMessage: "It appears your choosen passwords do not match, check and try again!!! ").showAlet()
                    return
                } else {
                    print("Let's go")
                    
//                    let customerInformation = [
//                        "first_name": firstName,
//                        "last_name": lastName,
//                        "email": email,
//                        "password": firstPassword
//                    ]
                    
                    Ringcaptcha.verifyOnboard(withAppKey: "5ygi4e1y1o8esa6i3uqe", andSecretKey: "ni4ozypimupy6osi1y3a", in: self, delegate: nil, success: { (RingcaptchaVerification) in
                        
                        var customerInformation = [
                            "first_name": firstName,
                            "last_name": lastName,
                            "email": email,
                            "password": firstPassword
                        ]
                        
                        customerInformation["phone_number"] = RingcaptchaVerification?.phoneNumber
                        self.networkService?.networkRequestToServer(requestEndpoint: "registercutomer", requestMethod: "POST", requestData: customerInformation, dataModel: Customer.self, completion: {[weak self] (result) in
                            switch result{
                            case .success(let user):
                                if (user.success_cue == "Success") {
                                    var custLog:[String: Any] = [:]
                                    custLog["success_cue"] = user.success_cue
                                    custLog["customer_id"] = user.customer_id
                                    custLog["first_name"] = user.first_name
                                    custLog["last_name"] = user.last_name
                                    custLog["phone_number"] = user.phone_number
                                    
                                    UserDefaults.standard.setValue(custLog, forKey: "customerLoggedin")
                                    NetworkService().switchViewController(storyboardid: "Main", storyboardidentifier: "searchRiderViewController")
                                    print("user back \(user.success_cue)")
                                    
                                } else if (user.success_cue == "Failed") {
                                    DeliPackAlert(context: self!, alertTitle: "Login Error", alertMessage: "Failed to log in try again later").showAlet()
                                    return
                                }
                            default:
                                break
                            }
                        })
                        
                         print("Successful")
                    }) { (RingcaptchaVerification) in
                        print("cancelled")
                    }
                }
            }
        }
    }
    
    
    
    
 
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if let userlogged = segue.destination as? SearchRiderController, let user = sender as? Customer {
            userlogged.customerLogged = user
        }
    }
 

}

