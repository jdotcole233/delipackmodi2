//
//  SearchRiderController.swift
//  deliPackiOS
//
//  Created by Gh0stM0de on 7/15/19.
//  Copyright © 2019 UltiTrust Company LTD. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SearchRiderController: UIViewController {
    
    var choice: Int = 0
    let lat = 5.6358
    let lng = -0.1614
    var pickUplat : Double = 0.0
    var pickUpLng : Double = 0.0
    var deliveryLat : Double = 0.0
    var deliveryLng : Double = 0.0
    var camera : GMSMutableCameraPosition?
    var pickUpName: String = ""
    var deliveryName: String = ""
    var polyPath: GMSMutablePath?
    
    @IBOutlet weak var locationFinderView: UIView!
    @IBOutlet weak var pickUpLocationResult: UITextField!
    @IBOutlet weak var deliveryLocationResult: UITextField!
    var googleMapView: GMSMapView?
    
   
    
    @IBOutlet var mapviewdisplay: GMSMapView!
    
    
    @IBAction func pickUpAutoCompleteSelect(_ sender: Any) {
        print("He")
        choice = 1
        openAutoCompleteSearch();
    }
    
    @IBAction func deliveryLocationAutoCompleteSelect(_ sender: Any) {
        choice = 2
        openAutoCompleteSearch()
    }
    
    @IBAction func searchRiderButton(_ sender: Any) {
        print("Button clicked")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
       
    
        
        
//        let camera = GMSMutableCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 16.0)
//        mapviewdisplay.animate(toZoom: 16.0)
        
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
//        marker.title = "East Legon"
//        marker.snippet = "Ghana"
//        marker.map = mapviewdisplay
        
        print("map view index \(mapviewdisplay.layer.zPosition)");
        print("map view index \(locationFinderView.layer.zPosition)");

    }
    
    func mapPlot(Lat: Double, Lng: Double, title: String) -> GMSMarker {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Lat, longitude: Lng)
        marker.title = title
        marker.snippet = "Ghana"
        
        return marker
    }
    
    
//    override func loadView() {
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func openAutoCompleteSearch(){
        let pickUpAutoCompleteController = GMSAutocompleteViewController()
        pickUpAutoCompleteController.delegate = self
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))!
        
        pickUpAutoCompleteController.placeFields = fields
        
        let filter = GMSAutocompleteFilter()
        //        filter.type = .address
        filter.country = "GH"
        
        pickUpAutoCompleteController.autocompleteFilter = filter
        
        present(pickUpAutoCompleteController, animated: true, completion: nil)
    }

}

extension SearchRiderController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        if choice == 1 {
            pickUpLocationResult.text = place.name
            print("pick up cordinates \(place.coordinate)")
            pickUplat = place.coordinate.latitude
            pickUpLng = place.coordinate.longitude
            pickUpName = place.name!
            
            if pickUplat != 0.0 && pickUpLng != 0.0 {
                camera = GMSMutableCameraPosition.camera(withLatitude: pickUplat, longitude: pickUpLng, zoom: 13.0)
                mapviewdisplay.animate(to: camera!)
                var pickUpMarker = GMSMarker()
                pickUpMarker = mapPlot(Lat: pickUplat, Lng: pickUpLng, title: pickUpName)
                pickUpMarker.map = mapviewdisplay
                polyPath?.add(CLLocationCoordinate2D(latitude: pickUplat, longitude: pickUpLng))
            }
            
            choice = 0
        } else if choice == 2 {
            deliveryLocationResult.text = place.name
            print("delivery cordinates \(place.coordinate)")
            deliveryLat = place.coordinate.latitude
            deliveryLng = place.coordinate.longitude
            deliveryName = place.name!
            
            if deliveryLat != 0.0 && deliveryLng != 0.0 {
                camera = GMSMutableCameraPosition.camera(withLatitude: deliveryLat, longitude: deliveryLng, zoom: 13.0)
                mapviewdisplay.animate(to: camera!)
                var deliveryMarker = GMSMarker()
                deliveryMarker = mapPlot(Lat: deliveryLat, Lng: deliveryLng, title: deliveryName)
                deliveryMarker.map = mapviewdisplay
                
                
                polyPath?.add(CLLocationCoordinate2D(latitude: deliveryLat, longitude: deliveryLng))
                let polyLink = GMSPolyline(path: polyPath)
                polyLink.map = mapviewdisplay
                
            }
            
            choice = 0
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
