//
//  HistoryDetailsViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 8/22/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class HistoryDetailsViewController: UIViewController {

    @IBOutlet weak var pickUpLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var riderNameLabel: UILabel!
    @IBOutlet weak var bikeRegisterNumberLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var transactionNumberLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var chargesLabel: UILabel!
    
    var customerDetails: CustomerHistoryModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(customerDetails!)
        pickUpLabel.text = customerDetails?.source
        deliveryLabel.text = customerDetails?.destination
        companyNameLabel.text = customerDetails?.company_name
        riderNameLabel.text = (customerDetails?.first_name!)! + " " + (customerDetails?.last_name!)!
        bikeRegisterNumberLabel.text = customerDetails?.registered_number
        transactionDateLabel.text = customerDetails?.created_at
        transactionNumberLabel.text = customerDetails?.transaction_number
        statusLabel.text = customerDetails?.delivery_status
        paymentLabel.text = customerDetails?.payment_type
        chargesLabel.text = customerDetails?.total_charge
        
        // Do any additional setup after loading the view.
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
