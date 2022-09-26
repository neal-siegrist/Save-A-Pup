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
    
    override init(viewType: ResultsViewType) {
        super.init(viewType: viewType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = AnimalResultsView()
        
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
        guard let currView = self.view as? AnimalResultsView else { return }
        guard let selectedRow = currView.listView.indexPathForSelectedRow else { return }
        
        currView.listView.cellForRow(at: selectedRow)?.isSelected = false
    }
    
    override func receivedLocation(location: CLLocation) {
        print("Animal results subclass received location: \(location)")
        
        print("Storing new location...")
        animalsWrapper.urlBuilder.addParameter(parameterName: .location, paramaterValue: "\(location.coordinate.latitude),\(location.coordinate.longitude)")
        
        //Fetch animals and update UI
        do {
            try animalsWrapper.fetchAnimals() {
                DispatchQueue.main.async {
                    guard let currView = self.view as? AnimalResultsView else { return }

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
        guard let currView = self.view as? AnimalResultsView else { return }
        
        currView.listView.dataSource = self
        currView.listView.delegate = self
        currView.listView.register(AnimalCell.self, forCellReuseIdentifier: AnimalCell.CELL_IDENTIFIER)
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
