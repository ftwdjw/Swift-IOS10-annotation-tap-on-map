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
    
    var i=0
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func tapOnMap(_ sender: UITapGestureRecognizer) {
        i += 1
        print("this is a tap on the map number=\(i)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

