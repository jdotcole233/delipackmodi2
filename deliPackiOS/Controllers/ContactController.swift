//
//  ContactController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/16/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class ContactController: UIViewController {

    @IBOutlet weak var instagramImageView: UIImageView!
    @IBOutlet weak var twitterImageView: UIImageView!
    @IBOutlet weak var facebookImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //facebookimage button interaction
        let facebookImageInteraction = UITapGestureRecognizer(target: self, action: #selector(self.facebookActionSwitch(facebookImageInteraction:)))
        facebookImageView.isUserInteractionEnabled = true
    facebookImageView.addGestureRecognizer(facebookImageInteraction)
        
        
        //twitter button interaction
        let twitterImageInteraction = UITapGestureRecognizer(target: self, action: #selector(self.twitterActionSwitch(twitterImageInteraction:)))
        twitterImageView.isUserInteractionEnabled = true
        twitterImageView.addGestureRecognizer(twitterImageInteraction)
        
        
        //instagram button interaction
        let instagramImageInteraction = UITapGestureRecognizer(target: self, action: #selector(self.instagramActionSwitch(instagramImageInteraction:)))
        instagramImageView.isUserInteractionEnabled = true
        instagramImageView.addGestureRecognizer(instagramImageInteraction)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func callDeliPack(_ sender: Any) {
        guard let phonenumber = URL(string: "tel://0503848404") else {
            print("click1")

            return}
//        UIApplication.shared.canOpenURL(phonenumber)
        if #available(iOS 10, *) {
            UIApplication.shared.open(phonenumber, options: [:], completionHandler: nil)
            print(UIApplication.shared.canOpenURL(phonenumber))
            print("click if")
        } else {
            UIApplication.shared.openURL(phonenumber)
            print("click else")
        }

    }
    
    
    
    @objc func facebookActionSwitch(facebookImageInteraction: UITapGestureRecognizer){
        
//        let facebookImageInteract = facebookImageInteraction.view as! UIImage
        openSocialMedia(socialAppURL: "fb://profile/", webAppURL: "https://www.facebook.com/", socialMediaScreenName: "deliPack")
        print("facebook tapped")
        
    }
    
    @objc func twitterActionSwitch(twitterImageInteraction: UITapGestureRecognizer){
        openSocialMedia(socialAppURL: "twitter://user?screen_name=", webAppURL: "https://twitter.com/", socialMediaScreenName: "delivpack")
        print("twitter tapped")
    }
    
    @objc func instagramActionSwitch(instagramImageInteraction: UITapGestureRecognizer){
        openSocialMedia(socialAppURL: "instagram://user?username=", webAppURL: "https://instagram.com/", socialMediaScreenName: "delivpack")
        print("instagram tapped")
    }
    
    
    func openSocialMedia(socialAppURL: String, webAppURL: String, socialMediaScreenName: String){
        
        let screenName = socialMediaScreenName
        let socialMediaAppURL = URL(string: socialAppURL + screenName)!
        let browserAppURL = URL(string: webAppURL + screenName)!
        
        if UIApplication.shared.canOpenURL(socialMediaAppURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(socialMediaAppURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(socialMediaAppURL)
            }
        } else {
            if  #available(iOS 10.0, *) {
                UIApplication.shared.open(browserAppURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(browserAppURL)
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


