//
//  BuildingViewController.swift
//  MAD9036 Final
//
//  Created by Ryan Bowes on 2017-12-13.
//  Copyright © 2017 Algonquin College. All rights reserved.
//

import UIKit
import MapKit

class BuildingViewController: UIViewController {
    @IBOutlet weak var lblBuildingName: UILabel!
    @IBOutlet weak var imgBuildingImage: UIImageView!
    @IBOutlet weak var txtBuildingDescription: UITextView!
    @IBOutlet weak var mkMap: MKMapView!
    
    var currentBuilding: Building?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let building = currentBuilding {
            lblBuildingName.text = building.nameEN
            txtBuildingDescription.text = building.descriptionEN
            mkMap.centerCoordinate.latitude = building.latitude
            mkMap.centerCoordinate.longitude = building.longitude
            
            var currentLocation: CLLocationManager = CLLocationManager()
            currentLocation.desiredAccuracy = kCLLocationAccuracyBest
            
            if let userLocation = currentLocation.location?.coordinate {
                let userAnnotation: MKPointAnnotation = MKPointAnnotation()
                userAnnotation.coordinate = userLocation
                userAnnotation.title = "You Are Here"
                
                mkMap.addAnnotation(userAnnotation)
            }
            
            
            // Add the current location
            
            
            // Set the map region
            let buildingLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
            let buildingRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(buildingLocation, 5000000, 5000000)
            
            mkMap.setRegion(buildingRegion, animated: true)
            
            // Add the Annotation (map marker)
            let buildingAnnotation: MKPointAnnotation = MKPointAnnotation()
            buildingAnnotation.coordinate = buildingLocation
            buildingAnnotation.title = building.nameEN

            mkMap.addAnnotation(buildingAnnotation)
            
            
            if let buildingImage = currentBuilding?.imageData {
                imgBuildingImage.image = UIImage(data: buildingImage)
            }
            
        }
    }
    
}
