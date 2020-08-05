//
//  ViewController.swift
//  SensorProject
//
//  Created by Patrick Nymark on 04/08/2020.
//  Copyright © 2020 Patrick Nymark. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        let geofenceRegionCenter = CLLocationCoordinate2DMake(37.33233141, -122.0312186)
        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 100, identifier: "notifymeonExit")
        geofenceRegion.notifyOnExit = true
        geofenceRegion.notifyOnEntry = true
        
        locationManager.startMonitoring(for: geofenceRegion)
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1500, longitudinalMeters: 1500)
            mapView.setRegion(viewRegion, animated: false)
        }
    }
}

extension ViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered region")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exited region")
    }
}

