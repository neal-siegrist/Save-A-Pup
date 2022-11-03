//
//  ShelterSearchController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 11/1/22.
//

import UIKit

class ShelterSearchController: UIViewController {
    
    var sheltersVC: ShelterResultsViewController
    var searchViewSheet: ShelterSearchView
    var currentSearchBar: UISearchBar?
    var locationData: LocationData?
    var didSendBackFromLocationSearch = false
    
    init(shelterVC: ShelterResultsViewController) {
        self.sheltersVC = shelterVC
        self.searchViewSheet = ShelterSearchView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = searchViewSheet
        
        setupNavigationController()
        setupShelterViewDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.endEditing(true)
    }

    private func setupNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Shelter Search"
        
        let leftImage = UIImage(named: "LeftBarCross.png")
        
        let leftImageAction = UIAction(title: "Back") { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: leftImage, primaryAction: leftImageAction, menu: nil)
        
        self.navigationController?.navigationBar.tintColor = .gray
    }
    
    func setupShelterViewDelegates() {
        searchViewSheet.nameSearchBar.delegate = self
        searchViewSheet.locationSearchBar.delegate = self
    }
}

extension ShelterSearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //perform search
        let searchCriteria = sheltersVC.sheltersWrapper.urlBuilder
        
        searchCriteria.clearParameters()
        
        if let shelterName = searchViewSheet.nameSearchBar.text, !shelterName.isEmpty {
            print("Shelter text: \(shelterName)")
            searchCriteria.addParameter(parameterName: .name, paramaterValue: shelterName)
        }
        
        if let locationText = searchViewSheet.locationSearchBar.text, !locationText.isEmpty {
            if locationText == "Current Location" {
                searchCriteria.addParameter(parameterName: .location, paramaterValue: "\(LocationManager.shared.location.coordinate.latitude),\(LocationManager.shared.location.coordinate.longitude)")
    
            } else {
                guard let locationData = locationData else { return }
                
                searchCriteria.addParameter(parameterName: .location, paramaterValue: "\(locationData.coordinates.latitude),\(locationData.coordinates.longitude)")
            }
        }
        
        sheltersVC.updateResults()
        
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //make sure location is valid and not blank
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.tag == 1 {
            searchViewSheet.nameSearchBar.resignFirstResponder()
            navigationController?.pushViewController(ShelterLocationSearchController(searchVC: self), animated: true)
            return false
        }
        
        return true
        
    }
}
