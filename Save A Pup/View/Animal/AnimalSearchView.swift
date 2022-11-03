//
//  AnimalSearchView.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 10/5/22.
//

import UIKit

class AnimalSearchView: UIView {
    
    var typeSearchBar = NoCursorTextField(), breedSearchBar = NoCursorTextField(), sizeSearchBar = NoCursorTextField(), genderSearchBar = NoCursorTextField(), ageSearchBar = NoCursorTextField(), colorSearchBar = NoCursorTextField(), coatSearchBar = NoCursorTextField(), statusSearchBar = NoCursorTextField(), locationSearchBar = NoCursorTextField()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "linkPurple")
        button.setTitle("Search", for: .normal)
        button.backgroundColor = UIColor(named: "linkPurple")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let doneToolbarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        return button
    }()
    
    let pickerToolbar: UIToolbar = {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(named: "linkPurple")
        toolBar.sizeToFit()
        return toolBar
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSearchTextField(textField: typeSearchBar, defaultText: "Type: All", tag: 0)
        setupSearchTextField(textField: breedSearchBar, defaultText: "Breed: All", tag: 1, userInteraction: false)
        setupSearchTextField(textField: sizeSearchBar, defaultText: "Size: All", tag: 2)
        setupSearchTextField(textField: genderSearchBar, defaultText: "Gender: All", tag: 3, userInteraction: false)
        setupSearchTextField(textField: ageSearchBar, defaultText: "Age: All", tag: 4)
        setupSearchTextField(textField: colorSearchBar, defaultText: "Color: All", tag: 5, userInteraction: false)
        setupSearchTextField(textField: coatSearchBar, defaultText: "Coat: All", tag: 6, userInteraction: false)
        setupSearchTextField(textField: statusSearchBar, defaultText: "Status: All", tag: 7)
        setupSearchTextField(textField: locationSearchBar, defaultText: "Current Location", tag: 8, leftImage: UIImage(systemName: "location"))
        
        setupContainingView()
        setupPicker()
        setupConstraints()
    }
    
    @objc func dismissPicker() {
        
        self.typeSearchBar.endEditing(true)
        self.breedSearchBar.endEditing(true)
        self.sizeSearchBar.endEditing(true)
        self.genderSearchBar.endEditing(true)
        self.ageSearchBar.endEditing(true)
        self.colorSearchBar.endEditing(true)
        self.coatSearchBar.endEditing(true)
        self.statusSearchBar.endEditing(true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSearchTextField(textField: UITextField, defaultText: String?, tag: Int, leftImage: UIImage? = UIImage(systemName: "magnifyingglass"), userInteraction: Bool = true) {
        textField.isUserInteractionEnabled = userInteraction
        if !userInteraction { textField.backgroundColor = .lightGray }
        
        
        textField.text = defaultText
        textField.tag = tag
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 5.0
        textField.leftView = UIImageView(image: leftImage)
        textField.selectedTextRange = nil
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupContainingView() {
        self.backgroundColor = .white
    }

    func setupPicker() {
        pickerToolbar.setItems([doneToolbarButton], animated: true)
        pickerToolbar.isUserInteractionEnabled = true
    }
    
    func setupConstraints() {
        setupScrollViewConstraints()
        setupScrollContainerConstraints()
        
        setupDefaultFieldConstraints(searchBar: typeSearchBar, stackView: scrollViewContainer, horizontalPadding: 20.0, heightMinAnchor: 35.0)
        setupDefaultFieldConstraints(searchBar: breedSearchBar, stackView: scrollViewContainer, horizontalPadding: 20.0, heightMinAnchor: 35.0)
        setupDefaultFieldConstraints(searchBar: sizeSearchBar, stackView: scrollViewContainer, horizontalPadding: 20.0, heightMinAnchor: 35.0)
        setupDefaultFieldConstraints(searchBar: genderSearchBar, stackView: scrollViewContainer, horizontalPadding: 20.0, heightMinAnchor: 35.0)
        setupDefaultFieldConstraints(searchBar: ageSearchBar, stackView: scrollViewContainer, horizontalPadding: 20.0, heightMinAnchor: 35.0)
        setupDefaultFieldConstraints(searchBar: colorSearchBar, stackView: scrollViewContainer, horizontalPadding: 20.0, heightMinAnchor: 35.0)
        setupDefaultFieldConstraints(searchBar: coatSearchBar, stackView: scrollViewContainer, horizontalPadding: 20.0, heightMinAnchor: 35.0)
        setupDefaultFieldConstraints(searchBar: statusSearchBar, stackView: scrollViewContainer, horizontalPadding: 20.0, heightMinAnchor: 35.0)
     
        setupLocationSearchBarConstraints()
        setupSearchButtonConstraints()
    }
    
    func setupScrollViewConstraints() {
        self.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func setupScrollContainerConstraints() {
        scrollView.addSubview(scrollViewContainer)
        
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func setupDefaultFieldConstraints(searchBar: UITextField, stackView: UIStackView, horizontalPadding: CGFloat, heightMinAnchor: CGFloat) {
        stackView.addArrangedSubview(searchBar)
        
        searchBar.inputView = pickerView
        searchBar.inputAccessoryView = pickerToolbar
        
        searchBar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: horizontalPadding).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -horizontalPadding).isActive = true
        searchBar.heightAnchor.constraint(greaterThanOrEqualToConstant: heightMinAnchor).isActive = true
    }
    
    func setupLocationSearchBarConstraints() {
        scrollViewContainer.addArrangedSubview(locationSearchBar)
        
        locationSearchBar.leadingAnchor.constraint(equalTo: scrollViewContainer.leadingAnchor, constant: 20).isActive = true
        locationSearchBar.trailingAnchor.constraint(equalTo: scrollViewContainer.trailingAnchor, constant: -20).isActive = true
        locationSearchBar.heightAnchor.constraint(greaterThanOrEqualToConstant: 35.0).isActive = true
    }
    
    func setupSearchButtonConstraints() {
        scrollViewContainer.addArrangedSubview(searchButton)
        
        searchButton.centerXAnchor.constraint(equalTo: scrollViewContainer.centerXAnchor).isActive = true
        searchButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
    }
}

class NoCursorTextField: UITextField {
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
}
