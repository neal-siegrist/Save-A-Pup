//
//  ShelterResultsViewController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/26/22.
//

import CoreLocation
import UIKit

class ShelterResultsViewController: ResultsViewController {
    
    var sheltersWrapper: ShelterResultsWrapper = ShelterResultsWrapper()
    
    override init(viewType: ResultsViewType) {
        super.init(viewType: viewType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = ShelterResultsView()
        
        let loadingSpinner = UIActivityIndicatorView()
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadingSpinner)
        
        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        loadingSpinner.startAnimating()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let currView = self.view as? ShelterResultsView else { return }
        guard let selectedRow = currView.listView.indexPathForSelectedRow else { return }
        
        currView.listView.cellForRow(at: selectedRow)?.isSelected = false
    }
    
    override func receivedLocation(location: CLLocation) {
        print("Shelter results subclass received location: \(location)")
        
        if LocationManager.shared.isFetching { return }
        
        print("Storing new location...")
        sheltersWrapper.urlBuilder.addParameter(parameterName: .location, paramaterValue: "\(location.coordinate.latitude),\(location.coordinate.longitude)")
        
        //Fetch shelters and update UI
        do {
            try sheltersWrapper.fetchShelters() {
                DispatchQueue.main.async {
                    guard let currView = self.view as? ShelterResultsView else { return }
                    
                    for view in currView.subviews {
                        if let loadingView = (view as? UIActivityIndicatorView) {
                            loadingView.stopAnimating()
                        }
                    }
                    
                    currView.listView.reloadData()
                }
            }
        } catch {
            print("Error occured fetching shelters. Error:\(error.localizedDescription)")
        }
    }
    
    func setupTableView() {
        guard let currView = self.view as? ShelterResultsView else { return }
        
        currView.listView.dataSource = self
        currView.listView.delegate = self
        currView.listView.register(ShelterCell.self, forCellReuseIdentifier: ShelterCell.CELL_IDENTIFIER)
    }
}

extension ShelterResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sheltersWrapper.getSheltersCount()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currView = self.view as? ShelterResultsView else { fatalError("Cannot create shelter cell.") }
        
        let shelters = sheltersWrapper.getShelters()
        let cell = currView.listView.dequeueReusableCell(withIdentifier: ShelterCell.CELL_IDENTIFIER) as! ShelterCell
        
        cell.nameLabel.text = shelters[indexPath.section].name

        if let address = shelters[indexPath.section].address?.address1 {
            cell.addressLabel.text = address
        }
        
        if let distance = shelters[indexPath.section].distance {
            cell.distanceLabel.text = "\(Int(round(distance))) mi."
        }

        if let city = shelters[indexPath.section].address?.city {
            var cityStateString: String = city

            if let state = shelters[indexPath.section].address?.state {
                cityStateString.append(", \(state)")
            }

            cell.cityStateLabel.text = cityStateString
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shelter = sheltersWrapper.getShelters()[indexPath.section]
        guard let currView = self.view as? ShelterResultsView else { return }
        
        navigationController?.pushViewController(ShelterDetailViewController(shelter: shelter), animated: true)
    }
}
