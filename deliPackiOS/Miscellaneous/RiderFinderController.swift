//
//  RiderFinderController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 8/5/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import Foundation
import Firebase
import GeoFire

class RiderFinderController {
    
    let SEARCH_RADIUS = 20.0
    var riderFound: Bool = false
    var riderAvailable: Bool = false
    var proximity: Double = 0.1
    var context:UIViewController?
    var riderLocationAvailable: String?
    var pickUpLat: CLLocationDegrees?
    var pickUpLong: CLLocationDegrees?
    var customerID: String?
    var riderId: String?
    
    
    init(context: UIViewController,
         riderLocationAvailable: String,
         pickUpLat: CLLocationDegrees,
         pickUpLong: CLLocationDegrees,
         customerID: String) {
        
        self.context = context
        self.riderLocationAvailable = riderLocationAvailable
        self.pickUpLat = pickUpLat
        self.pickUpLong = pickUpLong
        self.customerID = customerID
        
    }
    
    func findClosestBiker(){
        
        var databaseReference: DatabaseReference!
        databaseReference =   Database.database().reference()
        databaseReference.child(self.riderLocationAvailable!)
        
        let geofire = GeoFire(firebaseRef: databaseReference)
        
        let customerLocation = CLLocation(latitude: self.pickUpLat!, longitude: self.pickUpLong!)
        let queryRadius = geofire.query(at: customerLocation, withRadius: SEARCH_RADIUS)
        
        queryRadius.observeReady {
            if (!self.riderFound) {
                self.proximity += 0.1
                if self.proximity >= 20.0 {
                    self.riderAvailable = false
                    databaseReference.child("CustomerRiderRequest").child(self.customerID!).removeValue()
                   
                    //End seaerch loader view controller
                    
                    let errorMessage: String = "Rider not found You can try again later"
                    DeliPackAlert(context: self.context!, alertTitle: "Search complete", alertMessage: errorMessage).showAlet()
                } else {
                    self.findClosestBiker()
                }
            }
        }
        
        
        queryRadius.observe(GFEventType.keyEntered) { (key, location) in
            if (self.riderAvailable) {
                if (!self.riderFound) {
                      self.riderFound = true
                      self.riderId = key
                    
                      let databaseRiderAccepted =  databaseReference.child("CustomerRiderRequest").child(self.customerID!)
                      databaseRiderAccepted.child("rideraccepted").setValue("")
                      databaseRiderAccepted.child("riderid").setValue(key)
                    
                    let databaseRiderFound =  databaseReference.child("CustomerRiderRequest").child(self.customerID!)
                    databaseRiderFound.child("customer_id").setValue(self.customerID)
                    databaseRiderFound.child("assigned").setValue("true")
                    
                    self.proximity = 0.1
                }
            }
            
        }
        
        
        
    }
}
