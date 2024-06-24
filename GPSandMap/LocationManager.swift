//
//  LocationManager.swift
//  GPSandMap
//
//  Created by DISMOV on 15/06/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var address = ""
    var flag = false
    
    override init() {
        super.init()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
    
    func getCoordinateInfo(_ coord: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(coord) { placemarks, error in
            if error == nil {
                if let placemark = placemarks?.first {
                    let thoroughfare = (placemark.thoroughfare ?? "")
                    let subThoroughfare = (placemark.subThoroughfare ?? "")
                    let locality = (placemark.locality ?? "")
                    let subLocality = (placemark.subLocality ?? "")
                    let administrativeArea = (placemark.administrativeArea ?? "")
                    let subAdministrativeArea = (placemark.subAdministrativeArea ?? "")
                    let postalCode = (placemark.postalCode ?? "")
                    let country = (placemark.country ?? "")
                    self.address = "Dirección: \(thoroughfare) \(subThoroughfare) \(locality) \(subLocality) \(administrativeArea) \(subAdministrativeArea) \(postalCode) \(country)"
                }
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            //inicia gps para obtener lecturas hasta que se indique que se detenga
            //self.manager.startUpdatingLocation()
            
            //solo obtiene una lectura para determinar la posición actual del usuario
            self.manager.requestLocation()
        }
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            getCoordinateInfo(location)
        }
        self.manager.stopUpdatingLocation()
        //print("Ud. esta en \(location?.coordinate.latitude), \(location?.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("No se pueden obtener lecturas, favor de verificar su GPS")
    }
}
