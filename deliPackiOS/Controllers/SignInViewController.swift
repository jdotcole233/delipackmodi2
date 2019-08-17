//
//  SignInViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/24/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton! {
        didSet{
            signInButton.layer.cornerRadius = 8.0
        }
    }
    
    @IBOutlet weak var userPhoneNumber: UITextField!
    @IBOutlet weak var userPassword: UITextField! {
        didSet{
            userPassword.isSecureTextEntry = true
        }
    }
    
    var network: NetworkService?
    
    @IBAction func signButtonTapped(sender: UIButton){
        let customerPhoneNumber: String? = userPhoneNumber.text
        let customerPassword: String? = userPassword.text

        if (customerPhoneNumber!.isEmpty || customerPassword!.isEmpty) {
            DeliPackAlert(context: self, alertTitle: "Login Message", alertMessage: "Please input a valid phone number and password to access Delipack").showAlet()
            return
        } else {

            if (customerPhoneNumber!.count < 10 || customerPhoneNumber!.count > 10){
                DeliPackAlert(context: self, alertTitle: "Login Message", alertMessage: "Please input a valid phone number").showAlet()
                return
            } else if (customerPassword!.count < 8) {
                DeliPackAlert(context: self, alertTitle: "Login Message", alertMessage: "Please input a valid password").showAlet()
                return
            } else {
                let customerLoginData: [ String: Any] = [
                    "phone_number" : customerPhoneNumber!,
                    "password":customerPassword!
                ]
                print(customerLoginData)

                    self.network!.networkRequestToServer(requestEndpoint: "customer_login", requestMethod: "POST", requestData: customerLoginData, dataModel: Customer.self, dataFlag: "LOGIN") { (result) in
                        switch result {
                        case .success(let user) :
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
                                DeliPackAlert(context: self, alertTitle: "Login Error", alertMessage: "Failed to log in try again later").showAlet()
                                return
                            }
                        default:
                            break
                        }
                }
            }
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        signInButton.layer.cornerRadius = CGFloat(Int(bitPattern: 8))
        network = NetworkService()
    }
    

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "logintodashboard" {
            if let dashBoardSegue = segue.destination as? SearchRiderController, let customerInformation = sender {
                            dashBoardSegue.customerLogged = customerInformation as! Customer
            }
        }
        
    }



}
