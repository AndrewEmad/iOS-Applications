//
//  ViewController.swift
//  My Places
//
//  Created by Andrew on 8/13/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate=self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        if addPressed
        {
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction(_:)))
            longPress.minimumPressDuration = 2.0
            mapView.addGestureRecognizer(longPress)
            manager.startUpdatingHeading()
            manager.startUpdatingLocation()
        }
        else
        {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Route Me", style: .Plain, target: self, action: #selector(routeMe))
            let latSpan = 10.0
            let lngSpan = 10.0
            let span = MKCoordinateSpanMake(latSpan, lngSpan)
            let coordinates = CLLocationCoordinate2DMake(myPlaces[activePlace].latitude, myPlaces[activePlace].longitude)
            let region = MKCoordinateRegionMake(coordinates, span)
            mapView.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = myPlaces[activePlace].name
            mapView.addAnnotation(annotation)
        }
        
    }
    
    func routeMe(){
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
    
    func longPressAction ( gesture : UIGestureRecognizer ) {
        let message = UIAlertController(title: "Add New Place", message: "Please Enter the Name of your Place", preferredStyle: .Alert)
        var textField: UITextField = UITextField()
        message.addTextFieldWithConfigurationHandler { (nameText) in
            textField = nameText
        }
        let okButtun = UIAlertAction(title: "OK", style: .Default) { (action) in
            if textField.text == nil || textField.text == "" {
                self.longPressAction(gesture)
            }
            let location = gesture.locationInView(self.mapView)
            let coordinates = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
            myPlaces.append(Place(name: textField.text!,latitude: coordinates.latitude, longitude: coordinates.longitude))
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = textField.text
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotation(annotation)
            let places = NSKeyedArchiver.archivedDataWithRootObject(myPlaces)
            NSUserDefaults.standardUserDefaults().setObject(places, forKey: "myPlaces")
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        message.addAction(okButtun)
        message.addAction(cancelButton)
        presentViewController(message, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.manager.stopUpdatingLocation()
        self.manager.startUpdatingHeading()
        let annotation = MKPointAnnotation()
        annotation.coordinate = locations[0].coordinate
        annotation.title = "You are here!"
        mapView.addAnnotation(annotation)
        if addPressed {
            return
        }
        let sourcePlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(myPlaces[activePlace].latitude, myPlaces[activePlace].longitude)
            , addressDictionary: nil)
        let destinationPlaceMark = MKPlacemark(coordinate: locations[0].coordinate, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        let destinationMapItem = MKMapItem(placemark: destinationPlaceMark)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .Automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculateDirectionsWithCompletionHandler { (response, error) in
            if error == nil && response != nil {
                let route = response!.routes[0]
                self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
            }
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 2.0
        
        return renderer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

