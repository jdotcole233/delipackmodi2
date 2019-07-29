//
//  WalkthroughContentViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/29/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 0
        }
    }
    
    
    @IBOutlet var subheadingLable:UILabel! {
        didSet {
            subheadingLable.numberOfLines = 0
        }
    }
    
    @IBOutlet var contentImageView: UIImageView!
    
    var sliderIndex = 0
    var headingText = ""
    var subHeadingtext = ""
    var contentImageFile = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingLabel.text = headingText
        subheadingLable.text = subHeadingtext
        contentImageView.image = UIImage(named: contentImageFile) 

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
