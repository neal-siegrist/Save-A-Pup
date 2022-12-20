//
//  ResultsViewController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/26/22.
//

import UIKit
import Combine
import CoreLocation

class ResultsViewController: UIViewController {
    
    private var locationSubscriber: AnyCancellable?
    private let viewType: ResultsViewType
    var isFetchingMoreData = false
    
    let loadingSpinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.stopAnimating()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewType: ResultsViewType) {
        self.viewType = viewType
        
        super.init(nibName: nil, bundle: nil)
        
        subscribeToLocation()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSetup()
    }
    
    func setupLoadingSpinner() {
        self.view.addSubview(loadingSpinner)
        
        NSLayoutConstraint.activate([
            loadingSpinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingSpinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        loadingSpinner.startAnimating()
    }
    
    private func subscribeToLocation() {
        locationSubscriber = LocationManager.shared.$location.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let failure):
                print("failure occured with error: \(failure)")
            case .finished:
                print("finished publishing")
            }
        }, receiveValue: { location in
            //New location received, updat the UI accordingly
            self.receivedLocation(location: location)
        })
    }
    
    private func performSetup() {
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let leftImage = UIImage(named: "LeftBarCross.png")
        let centerImage = viewType == .animalView ? UIImage(named: "Animals.png") : UIImage(named: "Shelters.png")
        
        let leftImageAction = UIAction(title: "Back") { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: leftImage, primaryAction: leftImageAction, menu: nil)
        self.navigationItem.titleView = UIImageView(image: centerImage)
        self.navigationController?.navigationBar.tintColor = .gray
    }
    
    func receivedLocation(location: CLLocation) { }
}
