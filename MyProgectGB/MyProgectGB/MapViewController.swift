//
//  MapViewController.swift
//  MyProgectGB
//
//  Created by Valeriy Fomin on 28/9/21.
//

import UIKit
import GoogleMaps
import CoreLocation

final class MapViewController: UIViewController {

    //MARK: - IBOutlet

    @IBOutlet weak var mapView: GMSMapView!

    //MARK: - Properties

    let coordinate = CLLocationCoordinate2D(latitude: 36.726184, longitude: -4.433000)
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()

    }

    //MARK: - Private Methods
    func configureMap() {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        mapView.camera = camera
//        mapView.delegate = self
    }

    func configureLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self

    }

    @IBAction func startButton(_ sender: UIBarButtonItem) {
        locationManager?.startUpdatingLocation()
    }

    @IBAction func itemButton(_ sender: UIBarButtonItem) {
        locationManager?.requestLocation()
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let coord = locations.first?.coordinate else { return }
        let marker = GMSMarker(position: coord)
        self.mapView.camera = GMSCameraPosition.camera(withTarget: coord, zoom: 17)
        marker.map = self.mapView
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


