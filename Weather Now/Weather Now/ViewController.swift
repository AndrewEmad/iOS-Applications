//
//  ViewController.swift
//  Weather Now
//
//  Created by Andrew on 8/9/17.
//  Copyright © 2017 Andrew. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    var location = CLLocation()
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getCurrentLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        else {
            getCurrentLocationButton.enabled=false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manager.location != nil{
            location = manager.location!
        }
            }
    @IBAction func displayWeather(sender: UIButton) {
        
        
        let url = NSURL(string: "http://www.weather-forecast.com/locations/\(cityTextField.text!)/forecasts/latest")
        cityTextField.resignFirstResponder()
        if url == nil {
            resultTextView.text = "Error ! City not found !"
            return
        }
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil || data == nil{
                self.resultTextView.text = "Undefined Error ! Please try again later"
                return
            }
            let pageSource = NSString(data: data!, encoding:NSUTF8StringEncoding)
            var content = pageSource?.componentsSeparatedByString("<p class=\"summary\"><b>")
            self.resultTextView.text = ""
            content?.removeAtIndex(0)
            dispatch_async(dispatch_get_main_queue(),{
                for i in content! {
                    let partial = i.componentsSeparatedByString("</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    self.resultTextView.text = self.resultTextView.text.stringByAppendingString(String(htmlEncodedString: partial[0]+partial[1].componentsSeparatedByString("</span>")[0])+"\n\n")
                }
            })
            
        }
        task.resume()
        
    }
    @IBAction func currentLocation(sender: UIButton) {
        let locValue:CLLocationCoordinate2D = self.location.coordinate
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let city = placeMark.administrativeArea
            {
                self.cityTextField.text = city
            }
        })

    }
    
}

