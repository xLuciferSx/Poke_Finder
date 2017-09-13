//
//  ViewController.swift
//  Poke_Finder
//
//  Created by Raivis on 13/09/2017.
//  Copyright © 2017 Raivis. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var mapHasCenteredOnce = false
    var geoFire: GeoFire!
    var geoFireRef: DatabaseReference!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView.delegate = self
        
        mapView.userTrackingMode = MKUserTrackingMode.follow
        
        geoFireRef = Database.database().reference()
        geoFire = GeoFire(firebaseRef: geoFireRef)
        
        
    }
  
    override func viewDidAppear(_ animated: Bool) {
    locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.showsUserLocation = true
        
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
      let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let loc = userLocation.location {
            if !mapHasCenteredOnce {
                centerMapOnLocation(location: loc)
                mapHasCenteredOnce = true
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView: MKAnnotationView?
    
        
        if annotation.isKind(of: MKUserLocation.self) {
         annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView?.image = UIImage(named: "ash")
        }
        
        return annotationView
        
    }
    
    func createSighting(forLocation location: CLLocation, withPokemon pokeid:Int) {
     
        geoFire.setLocation(location, forKey: "\(pokeid)")
        
    }
    
    func showSightingsOnMap(location: CLLocation) {
        
        
        
        }

    @IBAction func spotRandomPokemon(_ sender: Any) {
    }
}

