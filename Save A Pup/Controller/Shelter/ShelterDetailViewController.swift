//
//  ShelterDetailViewController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/26/22.
//

import UIKit

class ShelterDetailViewController: UIViewController {
    let shelterInfo: Shelter
    
    init(shelter: Shelter) {
        self.shelterInfo = shelter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shelterView = ShelterDetailView()
        shelterView.imgScrollView.delegate = self
        self.view = shelterView
        
        retrieveImages()
        setupNavigationController()
        assignShelterValues()
        addGestureRecognizers()
    }
    
    private func retrieveImages() {
        let photos = shelterInfo.photos
        guard let detailView = self.view as? ShelterDetailView, !photos.isEmpty else { return }
        
        var arr = [URL]()
        
        for photo in photos {
            guard let currPhoto = photo else { return }
            if let full = currPhoto.full {
                guard let url = URL(string: full) else { break }
                arr.append(url)
            }
        }
     
        detailView.addImages(urls: arr)
    }
    
    private func setupNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let leftImage = UIImage(named: "LeftBarCross.png")
        let centerImage = UIImage(named: "Shelters.png")
        
        let leftImageAction = UIAction(title: "Back") { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: leftImage, primaryAction: leftImageAction, menu: nil)
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.titleView = UIImageView(image: centerImage)
        self.navigationController?.navigationBar.tintColor = .gray
    }
    
    private func assignShelterValues() {
        guard let detailView = self.view as? ShelterDetailView else { return }
        
        detailView.sheltername = shelterInfo.name
        detailView.address = shelterInfo.address?.address1
        detailView.cityState = generateCityStateText()
        detailView.distance = shelterInfo.distance == nil ? nil : "\(String(format: "%.2f", shelterInfo.distance!)) mi."
        
        detailView.phone = shelterInfo.phone
        detailView.email = shelterInfo.email
        detailView.petfinderWebsite = shelterInfo.url
        detailView.shelterWebsite = shelterInfo.website
    }
    
    private func generateCityStateText() -> String? {
        var cityStateString: String = ""

        if let city = shelterInfo.address?.city {
            cityStateString.append(city)
        }

        if let state = shelterInfo.address?.state {
            if !cityStateString.isEmpty { cityStateString.append(", ") }
            cityStateString.append(state)
        }
        
        if let postcode = shelterInfo.address?.postcode {
            if !cityStateString.isEmpty { cityStateString.append(", ") }
            cityStateString.append(postcode)
        }

        return cityStateString.isEmpty ? nil : cityStateString
    }

    
    
    private func addGestureRecognizers() {
        guard let detailView = self.view as? ShelterDetailView else { print("guard failed") ; return }
        print("in adding gestures")
        
        let phoneGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPhone(_:)))
        detailView.addGesture(stack: .phone, gesture: phoneGesture)
        
        let emailGesture = UITapGestureRecognizer(target: self, action: #selector(didTapEmail(_:)))
        detailView.addGesture(stack: .email, gesture: emailGesture)

        let petfinderGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPetfinderWebsite(_:)))
        detailView.addGesture(stack: .petfinderWebsite, gesture: petfinderGesture)

        let websiteGesture = UITapGestureRecognizer(target: self, action: #selector(didTapWebsite(_:)))
        detailView.addGesture(stack: .shelterWebsite, gesture: websiteGesture)
    }
}

extension ShelterDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let detailView = self.view as? ShelterDetailView else { return }

        detailView.updateImageCount(numbered: Int(scrollView.contentOffset.x/scrollView.frame.size.width))
    }
}

extension ShelterDetailViewController: UIGestureRecognizerDelegate {
    
    @objc func didTapPhone(_ sender: UITapGestureRecognizer) {
        
        guard let detailView = self.view as? ShelterDetailView, let number = detailView.phone else { return }
        
        let phoneNumber = number.filter("0123456789".contains(_:))
        
        if !phoneNumber.isEmpty {
            let phoneCallUrl = URL(string: "tel://\(phoneNumber)")
            
            if let url = phoneCallUrl, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func didTapEmail(_ sender: UITapGestureRecognizer) {
        guard let detailView = self.view as? ShelterDetailView, let email = detailView.email else { return }
        
        if !email.isEmpty {
            let emailUrl = URL(string: "mailto:\(email)")
            
            if let url = emailUrl, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
    }

    @objc func didTapPetfinderWebsite(_ sender: UITapGestureRecognizer) {
        guard let detailView = self.view as? ShelterDetailView, let petfinder = detailView.petfinderWebsite else { return }
        
        if !petfinder.isEmpty {
            let petfinderURL = URL(string: petfinder)
            
            if let url = petfinderURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
    @objc func didTapWebsite(_ sender: UITapGestureRecognizer) {
        guard let detailView = self.view as? ShelterDetailView, let shelterSite = detailView.shelterWebsite else { return }
        
        if !shelterSite.isEmpty {
            let shelterURL = URL(string: shelterSite)
            
            if let url = shelterURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
    }
}
