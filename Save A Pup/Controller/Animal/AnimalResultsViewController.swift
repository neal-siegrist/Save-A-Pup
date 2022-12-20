//
//  AnimalResultsViewController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/6/22.
//

import UIKit
import CoreLocation

class AnimalResultsViewController: ResultsViewController {
    
    var animalsWrapper: AnimalResultsWrapper = AnimalResultsWrapper()
//    private var isFetchingMoreData = false
    
//    let loadingSpinner: UIActivityIndicatorView = {
//        let view = UIActivityIndicatorView()
//        view.stopAnimating()
//        view.hidesWhenStopped = true
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    override init(viewType: ResultsViewType) {
        super.init(viewType: viewType)
        
        //self.navigationItem.backButtonTitle = "Animals"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = AnimalResultsView()
        
        setupLoadingSpinner()
        
        setupTableView()
        setupSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        deselectTableRow()
    }
    
    private func deselectTableRow() {
        guard let currView = self.view as? AnimalResultsView else { return }
        guard let selectedRow = currView.listView.indexPathForSelectedRow else { return }
        
        currView.listView.cellForRow(at: selectedRow)?.isSelected = false
    }
    
    override func receivedLocation(location: CLLocation) {
        print("Animal results subclass received location: \(location)")
        
        if LocationManager.shared.isFetching { return }
        
        print("Storing new location...")
        animalsWrapper.urlBuilder.addParameter(parameterName: .location, paramaterValue: "\(location.coordinate.latitude),\(location.coordinate.longitude)")
        
        //Fetch animals and update UI
        updateResults()
        
    }
    
    func updateResults() {
        loadingSpinner.startAnimating()
        
        do {
            try animalsWrapper.fetchAnimals() {
                DispatchQueue.main.async { [weak self] in
                    guard let currView = self?.view as? AnimalResultsView else { return }

                    self?.loadingSpinner.stopAnimating()
                    
                    currView.listView.reloadData()
                }
            }
        } catch {
            print("Error occured fetching shelters. Error:\(error.localizedDescription)")
        }
    }
    
    func setupTableView() {
        guard let currView = self.view as? AnimalResultsView else { return }
        
        currView.listView.dataSource = self
        currView.listView.delegate = self
        currView.listView.register(AnimalCell.self, forCellReuseIdentifier: AnimalCell.CELL_IDENTIFIER)
    }
    
    func setupSearchButton() {
        let rightImage = UIImage(named: "Search.png")
        
        let rightImageAction = UIAction(title: "Search") { (action) in
            self.navigationController?.pushViewController(AnimalSearchController(animalVC: self), animated: true)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: rightImage, primaryAction: rightImageAction, menu: nil)
    }
}

extension AnimalResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return animalsWrapper.getAnimalsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let currView = self.view as? AnimalResultsView else { fatalError("Cannot create shelter cell.") }
        
        let animals = animalsWrapper.getAnimals()
        let cell = currView.listView.dequeueReusableCell(withIdentifier: AnimalCell.CELL_IDENTIFIER) as! AnimalCell
        cell.resetContent()
        
        if let imageUrl = animals[indexPath.section].primary_photo_cropped?.full, let url = URL(string: imageUrl) {
            cell.animalImageView.loadImage(url: url)
        } else {
            cell.animalImageView.image = UIImage(systemName: "xmark")
            cell.animalImageView.tintColor = UIColor(named: Constants.Colors.DARK_GREY)
        }
        
        cell.nameLabel.text = animals[indexPath.section].name
        cell.breedLabel.text = animals[indexPath.section].breeds?.primary
        cell.ageLabel.text = animals[indexPath.section].age
        cell.genderLabel.text = animals[indexPath.section].gender
        cell.cityStateLabel.text = animals[indexPath.section].contact?.address?.city
        if let distance = animals[indexPath.section].distance {
            cell.distanceLabel.text = "\(Int(round(distance))) mi."
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animal = animalsWrapper.getAnimals()[indexPath.section]
        
        navigationController?.pushViewController(AnimalDetailViewController(animal: animal), animated: true)
    }
}

extension AnimalResultsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let currView = self.view as? AnimalResultsView else { fatalError("The view is not a 'AnimalResultsView'") }
        
        let scrollViewPosition = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.frame.height
        let contentSizeHeight = currView.listView.contentSize.height
        let heightFetchingThreshold: CGFloat = 100
        
        if (scrollViewPosition + scrollViewHeight) > (contentSizeHeight - heightFetchingThreshold) && animalsWrapper.getAnimalsCount() > 0 && !isFetchingMoreData && animalsWrapper.isNextPageAvailable() {
            currView.listView.tableFooterView = createFooterLoadingSpinner()
            isFetchingMoreData = true
            
            //Fetch more animals
            do {
                try animalsWrapper.fetchAnimals(isFetchingNextPage: true) { [weak self] in
                    DispatchQueue.main.async {
                        guard let currView = self?.view as? AnimalResultsView else { return }
                        
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
        guard let currView = self.view as? AnimalResultsView else { fatalError("The view is not a 'AnimalResultsView'") }
        
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
