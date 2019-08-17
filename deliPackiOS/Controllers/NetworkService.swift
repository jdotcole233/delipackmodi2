//
//  NetworkService.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 8/5/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import Foundation

class NetworkService {
    
    //MARK :- Properties
//    var context: UIViewController?
    var baseUrl: String = "http://192.168.100.5:8000/api/"
    
    
    //MARK :- constructor
//    init(context: UIViewController) {
////        self.context = context
//    }
    
    //MARK :- methods
    func networkRequestToServer<T: Decodable>(requestEndpoint: String,
                                requestMethod: String,
                                requestData: [String: Any],
                                dataModel: T.Type,
                                dataFlag: String,
                                completion: @escaping (Result<T>)->Void){
        
        let registerURL = URL(string: baseUrl + requestEndpoint)
        let registerURLsession = URLSession.shared
        var registerURLRequest = URLRequest(url: registerURL!)
        registerURLRequest.httpMethod = requestMethod
        print("data to be sent \(requestData)")
        do {
            registerURLRequest.httpBody = try JSONSerialization.data(withJSONObject: requestData, options: JSONSerialization.WritingOptions.prettyPrinted)
            print("body to be sent \(registerURLRequest.httpBody)")

        } catch let error {
            print(error.localizedDescription)
        }
        
        registerURLRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        registerURLRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        let alertDeliPack = DeliPackAlert.init(context: context!, alertTitle: "", alertMessage: "Please wait")
//        alertDeliPack.showLoaderAlert()
        
        
        let registrationTask = registerURLsession.dataTask(with: registerURLRequest, completionHandler: { (data, URLResponse, error) in
            print("session to be sent \(data) \(URLResponse) \(error)")

            DispatchQueue.main.async {
                guard error == nil else {
                    return
                }
                
                print(error.debugDescription)

                
                guard let responseData = data else {
                    return
                }
//                    alertDeliPack.hideLoaderAler()
                print("undecoded1 \(responseData)")
                print(dataFlag)
                if dataFlag == "LOGIN" {
                    if let customer = try? JSONDecoder().decode(dataModel.self , from: responseData) {
                        print("decoded \(customer)")
                        //                        if customer == nil {
                        print(responseData)
                        //                        }
                        completion(.success(customer))
                    }
                } else if dataFlag == "HISTORY" {
                    print("In History")
                    if let customers = try? JSONDecoder().decode([CustomerHistoryModel].self , from: responseData) {
                        print("decoded \(customers.count)")
                        //                        if customer == nil {
                        print(responseData)
                        //                        }
//                        completion(.success(customers))
//                        completion(.History_success(/customers))
                    }
                }
            }
        })
        registrationTask.resume()
    }
    
    
    func switchViewController(storyboardid: String, storyboardidentifier: String){
        let storyboard = UIStoryboard(name: storyboardid, bundle: nil)
        let uiview = storyboard.instantiateViewController(withIdentifier: storyboardidentifier) as? UITabBarController
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.rootViewController = uiview
        
    }

}
