//
//  HistoryTableViewController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 8/6/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var customerHistory = [CustomerHistoryModel]()

    @IBOutlet var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return customerHistory.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCustomCell", for: indexPath) as! HistoryTableViewCell
        cell.companyNameLabel.text = customerHistory[indexPath.row].company_name
        cell.pickUpFromLabel.text = customerHistory[indexPath.row].source
        cell.deliverToLabel.text = customerHistory[indexPath.row].destination
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var singlecustomerHistory: CustomerHistoryModel?
        singlecustomerHistory = customerHistory[indexPath.row]
        performSegue(withIdentifier: "historyDetailsSegue", sender: singlecustomerHistory)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "historyDetailsSegue" {
            if let historyDetails = segue.destination as? HistoryDetailsViewController, let historyData = sender as? CustomerHistoryModel {
                historyDetails.customerDetails = historyData
            }
//             print(self.historyTable.indexPathForSelectedRow)
        }
    }


}
