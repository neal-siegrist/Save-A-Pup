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
        
        setupLoadingSpinner()
        setupTableView()
        setupSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        deselectTableRow()
    }
    
    private func deselectTableRow() {
        guard let currView = self.view as? ShelterResultsView else { return }
        guard let selectedRow = currView.listView.indexPathForSelectedRow else { return }
        
        currView.listView.cellForRow(at: selectedRow)?.isSelected = false
    }
    
    func setupSearchButton() {
        let rightImage = UIImage(named: "Search.png")
        
        let rightImageAction = UIAction(title: "Search") { (action) in
            self.navigationController?.pushViewController(ShelterSearchController(shelterVC: self), animated: true)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: rightImage, primaryAction: rightImageAction, menu: nil)
    }
    
    override func receivedLocation(location: CLLocation) {
        print("Shelter results subclass received location: \(location)")
        
        if LocationManager.shared.isFetching { return }
        
        print("Storing new location...")
        sheltersWrapper.urlBuilder.addParameter(parameterName: .location, paramaterValue: "\(location.coordinate.latitude),\(location.coordinate.longitude)")
        
        //Fetch shelters and update UI
        updateResults()
    }
    
    func updateResults() {
        loadingSpinner.startAnimating()
        
        do {
            try sheltersWrapper.fetchShelters() {
                DispatchQueue.main.async { [weak self] in
                    guard let currView = self?.view as? ShelterResultsView else { return }
                    
                    self?.loadingSpinner.stopAnimating()
                    
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
        
        cell.resetCellData()
        
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
        
        navigationController?.pushViewController(ShelterDetailViewController(shelter: shelter), animated: true)
    }
}

extension ShelterResultsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let currView = self.view as? ShelterResultsView else { fatalError("The view is not a 'ShelterResultsView'") }
        
        let scrollViewPosition = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.frame.height
        let contentSizeHeight = currView.listView.contentSize.height
        let heightFetchingThreshold: CGFloat = 100
        
        if (scrollViewPosition + scrollViewHeight) > (contentSizeHeight - heightFetchingThreshold) && sheltersWrapper.getSheltersCount() > 0 && !isFetchingMoreData && sheltersWrapper.isNextPageAvailable() {
            currView.listView.tableFooterView = createFooterLoadingSpinner()
            isFetchingMoreData = true
            
            //Fetch more shelters
            do {
                try sheltersWrapper.fetchShelters(isFetchingNextPage: true) { [weak self] in
                    DispatchQueue.main.async {
                        guard let currView = self?.view as? ShelterResultsView else { return }
                        
                        currView.listView.tableFooterView?.isHidden = true
                        currView.listView.reloadData()
                        self?.isFetchingMoreData = false
                    }
                }
            } catch {
                print("Error occured fetching shelters. Error:\(error.localizedDescription)")
            }
        }
    }
    
    private func createFooterLoadingSpinner() -> UIView {
        guard let currView = self.view as? ShelterResultsView else { fatalError("The view is not a 'ShelterResultsView'") }
        
        if let currentSpinner = currView.listView.tableFooterView {
            currentSpinner.isHidden = false
            return currentSpinner
        }

        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))

        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()

        return footerView
    }
}
