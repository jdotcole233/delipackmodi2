 //
//  WalkthroughPageViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/29/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource  {

    var pageHeadings = ["WELCOME","Track your errand","MAKE PAYMENT"]
    var pageSubheadings = ["Search for a rider by choosing your pick up location and delivery location. Then allow us to find the closest rider to serve you", "Follow your rider in real time as he/she makes delivery to/for you", "Pay for your delivery by choosing either mobile money or cash. You never have to stress"]
    var pageImages = ["appstore_logo_o","trackIcon","icons_payment_history"]
    
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).sliderIndex
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).sliderIndex
        index += 1
        
        return contentViewController(at: index)
    }

    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if currentIndex < 0 || currentIndex > pageHeadings.count {
            return nil
        }
        
        let storyboard = UIStoryboard(name: "WelcomeWalkthrough", bundle: nil)
        
        
        
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
