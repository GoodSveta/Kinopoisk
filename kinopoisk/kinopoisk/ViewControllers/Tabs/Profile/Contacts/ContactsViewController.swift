//
//  ContactsViewController.swift
//  kinopoisk
//
//  Created by mac on 4.04.22.
//

import UIKit
import MapKit

class ContactsViewController: UIViewController {
    private let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        locationManager.startUpdatingLocation()
    
    }
    
}
extension ContactsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        mapView.setCenter(location.coordinate, animated: true)
        locationManager.stopUpdatingLocation() // не забывать при выходе экрана добавлять это чтобы не было утечки памяти
    }
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        let geocoder = CLGeocoder()
        
    }
    
}
