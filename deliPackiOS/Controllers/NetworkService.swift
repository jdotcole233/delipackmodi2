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
    var context: UIViewController?
    var baseUrl: String = "http://192.168.100.3:8000/api/"
    
    
    //MARK :- constructor
    init(context: UIViewController) {
        self.context = context
    }
    
    //MARK :- methods
    func networkRequestToServer(requestEndpoint: String,
                                requestMethod: String,
                                requestData: [String: Any],
                                completion: @escaping (Result)->Void){
        
        let registerURL = URL(string: baseUrl + requestEndpoint)
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
        let alertDeliPack = DeliPackAlert.init(context: context!, alertTitle: "", alertMessage: "Please wait")
        alertDeliPack.showLoaderAlert()
        
        
        let registrationTask = registerURLsession.dataTask(with: registerURLRequest, completionHandler: { (data, URLResponse, error) in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    return
                }
                
                print(error.debugDescription)

                
                guard let responseData = data else {
                    return
                }
                    //                        if let jsonconverter = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]{
                    //                            print(jsonconverter)
                                                alertDeliPack.hideLoaderAler()
                    //                            completion(.success(<#T##Customer#>))
                    //                        }
                    if let customer = try? JSONDecoder().decode(Customer.self, from: responseData) {
                        print(customer)
                        completion(.success(customer))
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
