//
//  LocationManager.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/26/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    public static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation = CLLocation(latitude: 38.8815959, longitude: -122.0739578)
    
    override private init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
    }
    
    func updateToCurrentLocation() {
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        print("locationManagerDidChangeAuthorization called ...")
        
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("authorized")
            manager.requestLocation()
        case .denied, .restricted:
            print("not allowed")
            manager.requestLocation()
        case .notDetermined:
            print("not determined")
        @unknown default:
            print("unknown case")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations called")
       
        guard let currLocation = locations.last else { return }
        
        self.location = currLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let clError = error as? CLError else { return }
        
        switch clError.code {
            case .locationUnknown:
                print("cannot determine location")
            case .denied:
                print("location denied")
                manager.stopUpdatingLocation()
            case .network:
                print("network unavailable or network error")
            default:
                print("default")
        }
    }
}
