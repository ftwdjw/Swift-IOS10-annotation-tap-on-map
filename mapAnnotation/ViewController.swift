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

class ViewController: UIViewController, MKMapViewDelegate,
CLLocationManagerDelegate {
    
    //variables
    var measurement=0
    var i=0
    var latitude=0.0
    var longitude=0.0
    var dropPin=true
    let annotation = MKPointAnnotation()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func tapOnMap(_ gestureRecognizer: UITapGestureRecognizer) {
        i += 1
        
        let annotation = MKPointAnnotation()
        
        if dropPin==true{
        print("this is a tap on the map number=\(i)")
        print("latiutude=\(latitude)")
        print("longitude=\(longitude)")
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        annotation.title = "My Parking Location"
        annotation.coordinate = newCoordinates
            mapView.addAnnotation(annotation)
             dropPin=false
        }
            
        else{
            mapView.removeAnnotations([annotation])
        }
        
    }
    
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
        
        print("update last location")
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        latitude=location!.coordinate.latitude
        longitude=location!.coordinate.longitude
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapView.setRegion(region, animated: true)
        
        //add annotation
        if dropPin==true{
            annotation.title = "My Parking Location"
            annotation.coordinate = center
            mapView.addAnnotation(annotation)
            
        }
        else{
            mapView.removeAnnotations([annotation])
        }
        
        
        
        
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

