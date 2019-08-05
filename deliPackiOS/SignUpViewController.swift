//
//  SignUpViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/24/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit
// import Ringcaptcha

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customerPassword.isSecureTextEntry = true
        customerConfirmPassword.isSecureTextEntry = true
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
                        
                            self.networkRequestToServer(requestURL: "http://192.168.100.3:8000/api/registercutomer", requestMethod: "POST", requestData: customerInformation)
                        
                         print("Successful")
                    }) { (RingcaptchaVerification) in
                        print("cancelled")
                    }
                
        
                    

                    
                }
            }
        }
    }
    
    
    
    
    func networkRequestToServer(requestURL: String, requestMethod: String, requestData: [String: Any], completion: @escaping (Result< Customer, Error>)->Void){
        let registerURL = URL(string: requestURL)
        let registerURLsession = URLSession.shared
        var registerURLRequest = URLRequest(url: registerURL!)
        registerURLRequest.httpMethod = requestMethod
        do {
            registerURLRequest.httpBody = try JSONSerialization.data(withJSONObject: requestData, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        registerURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        registerURLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        let alertDeliPack = DeliPackAlert.init(context: self, alertTitle: "", alertMessage: "Please wait")
        alertDeliPack.showLoaderAlert()
        let registrationTask = registerURLsession.dataTask(with: registerURLRequest, completionHandler: { (data, URLResponse, error) in
            
            DispatchQueue.main.async {
                    guard error == nil else {
                        return
                    }
                
                    guard let responseData = data else {
                        return
                    }
                
                    do {
                        if let jsonconverter = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]{
                            print(jsonconverter)
                            alertDeliPack.hideLoaderAler()
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            
                            if let searchRiderViewController = storyboard.instantiateViewController(withIdentifier: "searchRiderViewController") as? SearchRiderController{
                                self.present(searchRiderViewController, animated: true, completion: nil)
                            }
                            //                    self.navigationController?.pushViewController(SearchRiderController(), animated: true)
                            
                        }
                    } catch let error {
                        print(error.localizedDescription)
                    }
            }
        })
        
        registrationTask.resume()
    }
    
    // End of register customer click event
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

