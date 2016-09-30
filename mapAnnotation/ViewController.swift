//
//  ViewController.swift
//  mapAnnotation
//
//  Created by John Mac on 9/26/16.
//  Copyright © 2016 John Wetters. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation




class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}

class ViewController: UIViewController, MKMapViewDelegate,
CLLocationManagerDelegate {
    
    //variables
    var measurement=0
    var measurementSave = 0
    var i=0
    var latitude=0.0
    var longitude=0.0
    var dropPin=true
    var lastDropPin=false
    let annotation = MKPointAnnotation()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func start(_ sender: AnyObject) {
        dropPin=true
    }
    
    @IBAction func stop(_ sender: AnyObject) {
               dropPin=false
    }
    
    
    
    // MARK: - Properties
    
    lazy var locationManager : CLLocationManager = {
        
        let locationManager = CLLocationManager()
        
        //Set up location manager with defaults
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.delegate = self
        
        //Optimisation of battery
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.activityType = CLActivityType.fitness
        locationManager.allowsBackgroundLocationUpdates = false
        
        return locationManager
    }()

    
    
    
    //let locationManager = CLLocationManager()
    //initialize location mnanager

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
        dropPin=true
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CLLocation didUpdateLocations
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations
        locations: [CLLocation])
    {
        let location = locations.last
        
        print("update last location \(measurement)")
        measurement += 1
        
        
        latitude=location!.coordinate.latitude
        longitude=location!.coordinate.longitude
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        //add annotation
        if dropPin==true && lastDropPin==false {
          
            annotation.title = "My Parking Location"
            annotation.coordinate = center
            mapView.addAnnotation(annotation)
            measurementSave=measurement
            print("\nadd annotation\n")
            print("\nmeasurementSaved=\(measurementSave)\n")
            
        }
        if dropPin==false && lastDropPin==true {
            mapView.removeAnnotations([annotation])
            print("\nremove annotations\n")
        }
        
        
        
        lastDropPin=dropPin
        //self.locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.authorizedAlways {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = MKUserTrackingMode.follow
            
            print("\nPermission Allowed\n")
        } else {
            print("\nPermission Refused\n")
        }
    }
    
    // MARK: - LocationManagerError
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error:Error)
    {
        print("Error: " + error.localizedDescription)
    }

   

}

