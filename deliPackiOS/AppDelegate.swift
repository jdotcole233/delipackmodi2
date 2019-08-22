//
//  AppDelegate.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/15/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyB-nZxMXHnJxcbnuO_i9hJxqwkChuWuEj0")
        GMSPlacesClient.provideAPIKey("AIzaSyB-nZxMXHnJxcbnuO_i9hJxqwkChuWuEj0")
        FirebaseApp.configure()
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplication.backgroundFetchIntervalMinimum)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Background fetch working")
        
       
        NetworkService().networkRequestToServerHistory(requestEndpoint: "customertransactionhistory", requestMethod: "POST", requestData: ["customer_id" : 16], dataModel: CustomerHistoryModel.self, completion: { (customerHistoryCallBack) in
//            print("success \(customerHistoryCallBack)")
         //   let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
           // let historypage = mainstoryboard.instantiateViewController(withIdentifier: "historyViewController") as! HistoryTableViewController
             //   historypage.customerHistory = customerHistoryCallBack
               // self.window?.rootViewController = historypage
//            if let historyViewController = HistoryTableViewController.self as ViewController {
//                historyViewController.customerHistory = customerHistoryCallBack
//            }
            if let hn = self.window?.rootViewController as? UITabBarController {
                print("empl \(hn)")
                for av in hn.viewControllers! {
                    if let ab = av as? UINavigationController {
                        for ac in ab.viewControllers {
                            if let historyPage = ac as? HistoryTableViewController {
                                historyPage.customerHistory = customerHistoryCallBack
                                historyPage.historyTable.reloadData()
                            }

                        }

                    }
                }

            }
            
//            if let historynav = self.window?.rootViewController as? UITabBarController, let con = historynav.viewControllers {
//                for vwcon in con {
//                    if let aa = vwcon as? HistoryTableViewController {
//                        aa.customerHistory = customerHistoryCallBack
//                        print(aa)
//                    }
//                }
//            }
        })
    }
    
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

