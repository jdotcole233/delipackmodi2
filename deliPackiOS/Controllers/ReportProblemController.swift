//
//  ReportProblemController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/16/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class ReportProblemController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var problemSelection = ["Select report class","Something isn't working", "General feedback"]

    @IBOutlet weak var probblemsDropDownSelector: UIPickerView!
    @IBOutlet weak var selectedOutputFeed: UILabel!
    @IBOutlet weak var selectedOutputDetail: UILabel!
    @IBOutlet weak var selectedOutputDetailOne: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        probblemsDropDownSelector.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return problemSelection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return problemSelection[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selected: String = problemSelection[row]
        selectedOutputFeed.text = selected.uppercased()
        
        if problemSelection[row] == "Something isn't working" {
            selectedOutputDetail.text = "Briefly explain what happened."
            selectedOutputDetailOne.text = "How can we reproduce the issue."

        } else if problemSelection[row] == "General feedback" {
            selectedOutputDetail.text = "Briefly explain what you love or"
            selectedOutputDetailOne.text = "what could improve"
        } else {
            selectedOutputFeed.text = "YOUR FEEDBACK IS APPRECIATED"
            selectedOutputDetail.text = "Please select {SOMETHING ISN'T WORKING}"
            selectedOutputDetailOne.text = "or {GENERAL FEEDBACK}"
            return
        }
        print(problemSelection[row])
    }
}
