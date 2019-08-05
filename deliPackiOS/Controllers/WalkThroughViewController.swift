//
//  WalkThroughViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 8/4/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class WalkThroughViewController: UIViewController, WalkthroughPageViewControllerDelegate {
    
  
    
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var nextButton : UIButton! {
        didSet{
            nextButton.layer.cornerRadius = 15.0
            nextButton.layer.masksToBounds = true
        }
    } 
    @IBOutlet var skipButton : UIButton!
    var walkthroughpageviewcontroller: WalkthroughPageViewController?
    
    
    @IBAction func skipButtonTapped(sender: UIButton){
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        if let index = walkthroughpageviewcontroller?.currentIndex {
            switch index {
            case 0...1:
                walkthroughpageviewcontroller?.changeWalkthroughPage()
            case 2:
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
        
        updateUI()
    }

    
    func updateUI() {
        if let index = walkthroughpageviewcontroller?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("NEXT", for: UIControl.State.normal)
                skipButton.isHidden = false
                
            case 2:
                nextButton.setTitle("GET STARTED", for: UIControl.State.normal)
                skipButton.isHidden = true
                
            default:
                break
            }
            pageControl.currentPage = index
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let destination = segue.destination
        if let pageviewcontroller = destination as? WalkthroughPageViewController {
            walkthroughpageviewcontroller = pageviewcontroller
            walkthroughpageviewcontroller?.walkthroughDelegate = self
        }
        
    }

    

}
