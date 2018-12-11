//
//  MapViewController.swift
//  CheckinAppChallenge
//
//  Created by Renan Trapp on 10/12/18.
//  Copyright © 2018 Renan Trapp. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var locationManager = CLLocationManager()
    
    static func instantiate(latitude: Double, longitude: Double) -> MapViewController {
        guard let viewController = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {
            fatalError("Missing expected OnBoarding storyboard content")
        }
        
        viewController.latitude = latitude
        viewController.longitude = longitude
        
        return viewController
    }
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            mapView.layer.cornerRadius = 10
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func dismissDidPress(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let regionRadius: CLLocationDistance = 500
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        self.mapView.setRegion(coordinateRegion, animated: true)
        self.mapView.showsUserLocation = true
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        
        let station = Annotation(title: "Endereço", locationName: "Evento", discipline: "Aqui", coordinate: annotation.coordinate)
        
        self.mapView.addAnnotation(station)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "ENDERECO")
        }
        
        return annotationView
    }
}
