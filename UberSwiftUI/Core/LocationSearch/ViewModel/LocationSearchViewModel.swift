//
//  LocationSearchViewModel.swift
//  UberSwiftUI
//
//  Created by wizz on 4/10/23.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    //MARK: - Properties
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    var userLocation: CLLocationCoordinate2D?
    
    //MARK: - Lifecycle
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    //MARK: - Helpers
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion){
        //selectedLocationCoordinate = nil
        locationSearch(for: localSearch) { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                print("DEBUG: Location search failed with eorr : \(error.localizedDescription)")
                return
            }
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedLocationCoordinate = coordinate
        }
    }
    
    func locationSearch(for localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(for type: RideType)-> Double {
        guard let coordinate = selectedLocationCoordinate else { return 0.0 }
        guard let location = self.userLocation else { return 0.0 }
        
        let origin = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let destination = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        
        let tripDistanceInMeters = origin.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
        
    }
}

//MARK: - MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
