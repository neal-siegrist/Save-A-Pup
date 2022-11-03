//
//  LocationSearchController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 10/28/22.
//

import UIKit
import MapKit

class LocationSearchController: UIViewController {
    
    let searchVC: AnimalSearchController
    let searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "search a location..."
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    let tableView: UITableView = {
        let view = UITableView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    init(searchVC: AnimalSearchController) {
        self.searchVC = searchVC

        super.init(nibName: nil, bundle: nil)
        
        searchCompleter.delegate = self
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = "Location Search"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        setupNavigationController()
    }
    
    override func viewDidLoad() {
        let view = self.view!
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Location Search"
        
        let leftImage = UIImage(named: "LeftBarCross.png")
        
        let leftImageAction = UIAction(title: "Back") { (action) in
          
            self.navigationController?.popViewController(animated: true)
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: leftImage, primaryAction: leftImageAction, menu: nil)
        
        self.navigationController?.navigationBar.tintColor = .gray
    }
    
    private func processResultsAndDismiss(location: CLLocationCoordinate2D, locationTitle: String) {
        
        searchVC.searchViewSheet.locationSearchBar.text = locationTitle
        
        searchVC.locationData = LocationData(description: locationTitle, coordinates: location)
        
        navigationController?.popViewController(animated: true)
    }
}

extension LocationSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            searchResults.removeAll()
            tableView.reloadData()
        }
        
        searchCompleter.queryFragment = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension LocationSearchController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

extension LocationSearchController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

extension LocationSearchController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] (response, error) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else { return }
            guard let locationText = tableView.cellForRow(at: indexPath)?.textLabel?.text else { return }
            
            self?.searchBar.text = locationText
            
            self?.processResultsAndDismiss(location: coordinate, locationTitle: locationText)
        }
    }
}
