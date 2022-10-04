//
//  AnimalDetailViewController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/22/22.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    let animal: Animal
    
    init(animal: Animal) {
        self.animal = animal
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animalView = AnimalDetailView()
        animalView.imgScrollView.delegate = self
        self.view = animalView
        
        retrieveImages()
        setupNavigationController()
        assignAnimalValues()
        addGestureRecognizers()
    }
    
    private func retrieveImages() {
        let photos = animal.photos
        guard let detailView = self.view as? AnimalDetailView, !photos.isEmpty else { return }
        
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
        let centerImage = UIImage(named: "Animals.png")
        
        let leftImageAction = UIAction(title: "Back") { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: leftImage, primaryAction: leftImageAction, menu: nil)
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.titleView = UIImageView(image: centerImage)
        self.navigationController?.navigationBar.tintColor = .gray
    }
    
    private func assignAnimalValues() {
        guard let detailView = self.view as? AnimalDetailView else { return }
        
        detailView.animalName = animal.name
        detailView.address = animal.contact?.address?.address1
        detailView.cityState = generateCityStateText()
        detailView.distance = animal.distance == nil ? nil : "\(String(format: "%.2f", animal.distance!)) mi."
        detailView.status = animal.status
        detailView.type = animal.type
        detailView.breed = generateBreedText()
        detailView.color = generateColorText()
        detailView.age = animal.age
        detailView.gender = animal.gender
        detailView.size = animal.size
        detailView.coat = animal.coat
        detailView.attributes = generateAttributesText()
        
        detailView.phone = animal.contact?.phone
        detailView.email = animal.contact?.email
        detailView.petfinderWebsite = animal.url
    }
    
    private func generateCityStateText() -> String? {
        var cityStateString: String = ""

        if let city = animal.contact?.address?.city {
            cityStateString.append(city)
        }

        if let state = animal.contact?.address?.state {
            if !cityStateString.isEmpty { cityStateString.append(", ") }
            cityStateString.append(state)
        }
        
        if let postcode = animal.contact?.address?.postcode {
            if !cityStateString.isEmpty { cityStateString.append(", ") }
            cityStateString.append(postcode)
        }

        return cityStateString.isEmpty ? nil : cityStateString
    }
    
    private func generateBreedText() -> String?{
        var breeds: String = ""
        
        if let breed = animal.breeds {

            if let primary = breed.primary {
                if !breeds.isEmpty {
                    breeds.append(", ")
                }
                
                breeds.append(primary)
            }
            if let secondary = breed.secondary {
                if !breeds.isEmpty {
                    breeds.append(", ")
                }
                
                breeds.append(secondary)
            }
            if let isMixed = breed.mixed, isMixed {
                if !breeds.isEmpty {
                    breeds.append(", ")
                }
                
                breeds.append("Mixed")
            }
            
            if let isUnknown = breed.unknown, isUnknown {
                if !breeds.isEmpty {
                    breeds.append(", ")
                }
                
                breeds.append("Unknown")
            }
        }
        
        return breeds.isEmpty ? nil : breeds
    }
    
    private func generateColorText() -> String? {
        var colors: String = ""

        if let color = animal.colors {
            
            if let primary = color.primary {
                if !colors.isEmpty {
                    colors.append(", ")
                }
                
                colors.append(primary)
            }
            if let secondary = color.secondary {
                if !colors.isEmpty {
                    colors.append(", ")
                }
                
                colors.append(secondary)
            }
            if let tertiary = color.tertiary {
                if !colors.isEmpty {
                    colors.append(", ")
                }
                
                colors.append(tertiary)
            }
        }
        
        return colors.isEmpty ? nil : colors
    }
    
    private func generateAttributesText() -> String? {
        var attributesString: String = ""
        
        if let attributes = animal.attributes {
            
            if let spayNeut = attributes.spayed_neutered, spayNeut {
                if !attributesString.isEmpty {
                    attributesString.append(", ")
                }
                attributesString.append("Spayed/Neutered")
            }
            
            if let houseTrained = attributes.house_trained, houseTrained {
                if !attributesString.isEmpty {
                    attributesString.append(", ")
                }
                attributesString.append("House Trained")
            }
            
            if let declawed = attributes.declawed, declawed {
                if !attributesString.isEmpty {
                    attributesString.append(", ")
                }
                attributesString.append("Declawed")
            }
            
            if let specialNeeds = attributes.special_needs, specialNeeds {
                if !attributesString.isEmpty {
                    attributesString.append(", ")
                }
                attributesString.append("Special Needs")
            }
            
            if let shots = attributes.shots_current, shots {
                if !attributesString.isEmpty {
                    attributesString.append(", ")
                }
                attributesString.append("Shots Current")
            }
        }
        
        return attributesString.isEmpty ? nil : attributesString
    }
    
    private func addGestureRecognizers() {
        guard let detailView = self.view as? AnimalDetailView else { print("guard failed") ; return }
        print("in adding gestures")
        
        let phoneGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPhone(_:)))
        detailView.addGesture(stack: .phone, gesture: phoneGesture)
        
        let emailGesture = UITapGestureRecognizer(target: self, action: #selector(didTapEmail(_:)))
        detailView.addGesture(stack: .email, gesture: emailGesture)

        let petfinderGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPetfinderWebsite(_:)))
        detailView.addGesture(stack: .petfinderWebsite, gesture: petfinderGesture)

    }
}

extension AnimalDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let detailView = self.view as? AnimalDetailView else { return }
        
        detailView.updateImageCount(numbered: Int(scrollView.contentOffset.x/scrollView.frame.size.width))
    }
}

extension AnimalDetailViewController: UIGestureRecognizerDelegate {
    
    @objc func didTapPhone(_ sender: UITapGestureRecognizer) {
        
        guard let detailView = self.view as? AnimalDetailView, let number = detailView.phone else { return }
        
        let phoneNumber = number.filter("0123456789".contains(_:))
        
        if !phoneNumber.isEmpty {
            let phoneCallUrl = URL(string: "tel://\(phoneNumber)")
            
            if let url = phoneCallUrl, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func didTapEmail(_ sender: UITapGestureRecognizer) {
        guard let detailView = self.view as? AnimalDetailView, let email = detailView.email else { return }
        
        if !email.isEmpty {
            let emailUrl = URL(string: "mailto:\(email)")
            
            if let url = emailUrl, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
    }

    @objc func didTapPetfinderWebsite(_ sender: UITapGestureRecognizer) {
        guard let detailView = self.view as? AnimalDetailView, let petfinder = detailView.petfinderWebsite else { return }
        
        if !petfinder.isEmpty {
            let petfinderURL = URL(string: petfinder)
            
            if let url = petfinderURL, UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        
    }
    
}
