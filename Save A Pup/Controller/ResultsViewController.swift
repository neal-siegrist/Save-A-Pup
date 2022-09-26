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
        let rightImage = UIImage(named: "Search.png")
        let centerImage = viewType == .animalView ? UIImage(named: "Animals.png") : UIImage(named: "Shelters.png")
        
        let leftImageAction = UIAction(title: "Back") { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let rightImageAction = UIAction(title: "Search") { (action) in
            
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: leftImage, primaryAction: leftImageAction, menu: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: rightImage, primaryAction: rightImageAction, menu: nil)
        self.navigationItem.titleView = UIImageView(image: centerImage)
        self.navigationController?.navigationBar.tintColor = .gray
    }
    
    func receivedLocation(location: CLLocation) { }
}
