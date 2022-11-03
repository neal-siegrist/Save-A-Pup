//
//  ShelterSearchView.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 11/1/22.
//

import UIKit

class ShelterSearchView: UIView {
    
    let nameSearchBar: UISearchBar = {
        let nameSearchBar = UISearchBar()
        nameSearchBar.backgroundImage = UIImage()
        nameSearchBar.placeholder = "Enter shelter or blank to search all..."
        nameSearchBar.translatesAutoresizingMaskIntoConstraints = false
        nameSearchBar.enablesReturnKeyAutomatically = false
        nameSearchBar.tag = 0
        return nameSearchBar
    }()
    
    let locationSearchBar: UISearchBar = {
        let locationSearchBar = UISearchBar()
        locationSearchBar.backgroundImage = UIImage()
        locationSearchBar.text = "Current Location"
        locationSearchBar.placeholder = "No location will use current locaiton..."
        locationSearchBar.translatesAutoresizingMaskIntoConstraints = false
        locationSearchBar.tag = 1
        return locationSearchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContainingView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContainingView() {
        self.backgroundColor = .white
    }
    
    func setupConstraints() {
        setupNameSearchBarConstraints()
        setupLocationSearchBarConstraints()
    }
    
    func setupNameSearchBarConstraints() {
        self.addSubview(nameSearchBar)
        
        nameSearchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        nameSearchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        nameSearchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func setupLocationSearchBarConstraints() {
        self.addSubview(locationSearchBar)
        
        locationSearchBar.topAnchor.constraint(equalTo: nameSearchBar.bottomAnchor).isActive = true
        locationSearchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        locationSearchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
}

