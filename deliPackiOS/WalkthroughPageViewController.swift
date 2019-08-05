 //
//  WalkthroughPageViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/29/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

 protocol WalkthroughPageViewControllerDelegate:class {
    func didUpdatePageIndex(currentIndex: Int)
 }
 
 
class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate  {

    
    
    var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    
    var pageHeadings = ["WELCOME","Track your errand","MAKE PAYMENT"]
    var pageSubheadings = ["Search for a rider by choosing your pick up location and delivery location. Then allow us to find the closest rider to serve you", "Follow your rider in real time as he/she makes delivery to/for you", "Pay for your delivery by choosing either mobile money or cash. You never have to stress"]
    var pageImages = ["appstore_logo_o_copy","trackIcon","payment"]
    
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        dataSource = self
        delegate = self 
        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .reverse, animated: true, completion: nil)
        }
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
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        print("heading count \(pageHeadings.count)")
        let storyboard = UIStoryboard(name: "WelcomeWalkthrough", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "walkthroughcontentviewcontroller") as?
            WalkthroughContentViewController {
            print(index)
            pageContentViewController.contentImageFile = pageImages[index]
            pageContentViewController.headingText = pageHeadings[index]
            pageContentViewController.subHeadingtext = pageSubheadings[index]
            
            pageContentViewController.sliderIndex = index
            
            return pageContentViewController
            
        }
        
        return nil
    }
    
    
    func changeWalkthroughPage(){
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex){
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                currentIndex = contentViewController.sliderIndex
                
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
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
