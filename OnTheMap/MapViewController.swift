//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Jonathan Kim on 8/8/15.
//  Copyright (c) 2015 Jonathan Kim. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.visibleViewController.title = "On The Map"

        UdacityClient.sharedInstance().taskForStudentLocation(UdacityClient.Methods.ParseMethod, completionHandler: { (result, error) -> Void in
            var resultsArray = result["results"] as! NSArray

            var studentArray: NSMutableArray = NSMutableArray()

            for dict in resultsArray {
                var student: Student = Student(dictionary: dict as! NSDictionary)

                var testLocation = student.coordinate
                var annoation = MKPointAnnotation()
                annoation.coordinate = testLocation
                annoation.title = student.firstName
                annoation.subtitle = student.mediaURL
                dispatch_async(dispatch_get_main_queue()) {
                    self.mapView.addAnnotation(annoation)
                }

                studentArray.addObject(student)
            }

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: MKMapViewDelegate
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        var center = view.annotation.coordinate
        var coordinateSpan = MKCoordinateSpanMake(0.01, 0.01)

        var coordinateRegion = MKCoordinateRegionMake(center, coordinateSpan)
        self.mapView .setRegion(coordinateRegion, animated: true)
    }

    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)

        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIView

        if annotation.title == "Jonathan" {
            pin.image = UIImage(named: "mobilemakers")
        }

        return pin
    }
}
