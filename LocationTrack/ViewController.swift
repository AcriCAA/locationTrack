//
//  ViewController.swift
//  LocationTrack
//
//  Created by Corey Acri on 3/26/15.
//  Copyright (c) 2015 AcriSoft. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var theMap: MKMapView!
    @IBOutlet weak var theLabel: UILabel!
    
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Our Location Manager
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
        //setup MapView
        theMap.delegate = self
        theMap.mapType = MKMapType.Hybrid
        theMap.showsUserLocation = true
        
    }
    
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]){
        
        theLabel.text = "\(locations[0])"
        myLocations.append(locations[0] as CLLocation)
        
        let spanX = 0.007
        let spanY = 0.007
        
        var newRegion = MKCoordinateRegion(center: theMap.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        theMap.setRegion(newRegion, animated: true)
            if (myLocations.count > 1){
            
            var sourceIndex = myLocations.count - 1
            var desitinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[desitinationIndex].coordinate
            var a = [c1, c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            theMap.addOverlay(polyline)
            
    }
}

    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!)  -> MKOverlayRenderer! {

        if overlay is MKPolyline {
    
                var polylineRenderer = MKPolylineRenderer(overlay: overlay)
                polylineRenderer.strokeColor = UIColor.blueColor()
                polylineRenderer.lineWidth = 5
                return  polylineRenderer
    
}

        return nil

}

}