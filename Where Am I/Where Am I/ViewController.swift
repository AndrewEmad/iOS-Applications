//
//  ViewController.swift
//  Where Am I
//
//  Created by Andrew on 8/12/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    var manager = CLLocationManager()
    var counter = 0
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
       
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if counter > 0
        {
            return
        }
        let annotation = MKPointAnnotation()
        annotation.coordinate = locations[0].coordinate
        CLGeocoder().reverseGeocodeLocation(locations[0]) { (placemarks, error) in
            if error == nil && placemarks != nil{
                let address = CLPlacemark(placemark: placemarks![0])
                annotation.title = address.country
                annotation.subtitle = ""
                if address.subThoroughfare != nil{
                    annotation.subtitle?.appendContentsOf(address.subThoroughfare!)
                }
                
                if address.thoroughfare != nil{
                    annotation.subtitle?.appendContentsOf(", "+address.thoroughfare!)
                }
                
                if address.subAdministrativeArea != nil{
                    annotation.subtitle?.appendContentsOf("\n"+address.subAdministrativeArea!)
                }
                
                if address.subLocality != nil{
                    annotation.subtitle?.appendContentsOf(", "+address.subLocality!)
                }
                if address.locality != nil{
                    annotation.subtitle?.appendContentsOf("\n"+address.locality!)
                }


                let latDelta: CLLocationDegrees = 0.01
                let longDelta: CLLocationDegrees = 0.01
                let span = MKCoordinateSpanMake(latDelta, longDelta)
                let region = MKCoordinateRegionMake(locations[0].coordinate, span)
                self.mapView.setRegion(region, animated: true)
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotation(annotation)
                self.counter += 1
            }
        }
        
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
        }
        else {
            pinView!.annotation = annotation
        }
        
        //THIS IS THE GOOD BIT
        let subtitleView = UILabel()
        subtitleView.font = subtitleView.font.fontWithSize(12)
        subtitleView.numberOfLines = 0
        subtitleView.text = annotation.subtitle!
        pinView!.detailCalloutAccessoryView = subtitleView
        
        
        return pinView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

