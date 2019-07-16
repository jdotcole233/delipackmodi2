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
    
    @IBOutlet weak var locationFinderView: UIView!
    @IBOutlet weak var pickUpLocationResult: UITextField!
    @IBOutlet weak var deliveryLocationResult: UITextField!
    var googleMapView: GMSMapView?
   
    
    
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

        let lat = 5.6358
        let lng = -0.1614
        let camera = GMSMutableCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 16.0)
        googleMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = googleMapView
        view.layer.zPosition = 0
        print(googleMapView?.layer.zPosition)
        
        if locationFinderView != nil {
            print(locationFinderView.layer.zPosition)
        }

        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = "East Legon"
        marker.snippet = "Ghana"
        marker.map = googleMapView
    }
    
    
    override func loadView() {
    
    }

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
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue))!
        
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
            choice = 0
        } else if choice == 2 {
            deliveryLocationResult.text = place.name
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
