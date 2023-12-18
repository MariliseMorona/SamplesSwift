//
//  MapViewController.swift
//  POC_Geolocation
//
//  Created by marilise morona on 18/12/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressTextField: UITextField!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var selectedAddress: Address? = nil
    var lastLocation: CLLocationCoordinate2D? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
        
        if let address = selectedAddress {
            showRoute(address)
        }
    }

    @IBAction func tappedShowAddress(_ sender: UIButton) {
        getPossibleAddressFromText()
    }
    
    private func getPossibleAddressFromText() {
        var addresses = [Address]()
        if let address = addressTextField.text {
            CLGeocoder().geocodeAddressString(address) { (placemarks, error) in
                if error == nil {
                    for placemark in placemarks! {
                        addresses.append(self.convertToAdress(placemark: placemark))
                    }
                    self.showAdressesTable(addresses: addresses)
                } else {
                    let controller = UIAlertController(title: "Error", message: "Problem trying to fetch addresses from the text.", preferredStyle: UIAlertController.Style.alert)
                    self.present(controller, animated: true)
                }
            }
        }
    }
    
    private func convertToAdress(placemark: CLPlacemark) -> Address {
        return Address(name: placemark.postalAddress!.street, placemark: placemark, postalAddress: placemark.postalAddress!)
    }
    
    private func showAdressesTable(addresses: [Address]) {
        let addressesVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AddressesTableViewController") as! AddressesTableViewController
        addressesVc.addresses = addresses
        addressesVc.selectedAddress = { addresses in
            self.selectedAddress = addresses
        }
        self.navigationController?.pushViewController(addressesVc, animated: true)
    }
    
    private func showRoute(_ address: Address) {
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = address.placemark.location!.coordinate
        destinationAnnotation.title = address.name
        self.mapView.addAnnotation(destinationAnnotation)
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: lastLocation!))
        
        request.destination = MKMapItem(placemark: MKPlacemark(placemark: address.placemark))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard let unwrappedResponse = response else {
                return
            }
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            lastLocation = location.coordinate
            mapView.centerCoordinate = location.coordinate
            let region = mapView.regionThatFits(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 300.0, longitudinalMeters: 300.0))
            mapView.setRegion(region, animated: true)
        }
        
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline:  overlay as! MKPolyline)
        renderer.strokeColor = .orange
        renderer.lineWidth = 5.0
        return renderer
    }
}
