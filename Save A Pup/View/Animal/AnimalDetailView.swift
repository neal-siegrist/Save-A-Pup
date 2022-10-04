//
//  AnimalDetailView.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/22/22.
//

import UIKit

class AnimalDetailView: DetailView {
    
    private let HEADER_STACK_PADDING: CGFloat = 20.0
    
    //Heading Variables
    private var photoLabel, nameLabel, addressLabel, cityStateLabel, distanceLabel: UILabel!
    var photoCount = 0
    
    var imgScrollView: UIScrollView = {
        let imgScrollView = UIScrollView()
        imgScrollView.isPagingEnabled = true
        imgScrollView.isHidden = true
        imgScrollView.showsHorizontalScrollIndicator = false
        imgScrollView.translatesAutoresizingMaskIntoConstraints = false
        return imgScrollView
    }()
    
    let imgStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let headerVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dividerBar: UIView = {
        let dividerBar = UIView()
        dividerBar.backgroundColor = UIColor(named: Constants.Colors.DIVIDER_GREY)
        dividerBar.translatesAutoresizingMaskIntoConstraints = false
        return dividerBar
    }()
    
    //Content Variables
    private var statusLabel, typeLabel, breedLabel, colorLabel, ageLabel, genderLabel, sizeLabel, coatLabel, attributesLabel, environmentLabel, tagsLabel, emailLabel, phoneLabel, petfinderWebsiteLabel, shelterWebsiteLabel: UILabel!
    private var phoneStack, emailStack, petfinderWebsiteStack, shelterWebsiteStack: UIStackView!
    private var petfinderURL, shelterURL: String?
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentMode = .center
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Label Accessors
    
    var animalName: String? {
        get {
            return nameLabel.text
        }
        set {
            nameLabel.text = newValue
            nameLabel.isHidden = newValue == nil ? true : false
        }
    }
    
    var address: String? {
        get {
            return addressLabel.text
        }
        set {
            addressLabel.text = newValue
            addressLabel.isHidden = newValue == nil ? true : false
        }
    }
    
    var cityState: String? {
        get {
            return cityStateLabel.text
        }
        set {
            cityStateLabel.text = newValue
            cityStateLabel.isHidden = newValue == nil ? true : false
        }
    }
    
    var distance: String? {
        get {
            return distanceLabel.text
        }
        set {
            distanceLabel.text = newValue
            distanceLabel.isHidden = newValue == nil ? true : false
        }
    }
    
    var status: String? {
        get {
            return statusLabel.text
        }
        set {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                statusLabel.text = "Status: \(value)"
                statusLabel.isHidden = false
            } else {
                statusLabel.text = newValue
                statusLabel.isHidden = true
            }
        }
    }
    
    var type: String? {
        get {
            return typeLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                typeLabel.text = "Type: \(value)"
                typeLabel.isHidden = false
            } else {
                typeLabel.text = newValue
                typeLabel.isHidden = true
            }
        }
    }
    
    var breed: String? {
        get {
            return breedLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                breedLabel.text = "Breed: \(value)"
                breedLabel.isHidden = false
            } else {
                breedLabel.text = newValue
                breedLabel.isHidden = true
            }
        }
    }
    
    var color: String? {
        get {
            return colorLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                colorLabel.text = "Color: \(value)"
                colorLabel.isHidden = false
            } else {
                colorLabel.text = newValue
                colorLabel.isHidden = true
            }
        }
    }
    
    var age: String? {
        get {
            return ageLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                ageLabel.text = "Age: \(value)"
                ageLabel.isHidden = false
            } else {
                ageLabel.text = newValue
                ageLabel.isHidden = true
            }
        }
    }

    var gender: String? {
        get {
            return genderLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                genderLabel.text = "Gender: \(value)"
                genderLabel.isHidden = false
            } else {
                genderLabel.text = newValue
                genderLabel.isHidden = true
            }
        }
    }
    
    var size: String? {
        get {
            return sizeLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                sizeLabel.text = "Size: \(value)"
                sizeLabel.isHidden = false
            } else {
                sizeLabel.text = newValue
                sizeLabel.isHidden = true
            }
        }
    }
    
    var coat: String? {
        get {
            return coatLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                coatLabel.text = "Coat: \(value)"
                coatLabel.isHidden = false
            } else {
                coatLabel.text = newValue
                coatLabel.isHidden = true
            }
        }
    }
    
    var attributes: String? {
        get {
            return attributesLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                attributesLabel.text = "Attributes: \(value)"
                attributesLabel.isHidden = false
            } else {
                attributesLabel.text = newValue
                attributesLabel.isHidden = true
            }
        }
    }
    
    var environment: String? {
        get {
            return environmentLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                environmentLabel.text = "Environment: \(value)"
                environmentLabel.isHidden = false
            } else {
                environmentLabel.text = newValue
                environmentLabel.isHidden = true
            }
        }
    }
    
    var tags: String? {
        get {
            return tagsLabel.text
        }
        set(newValue) {
            if let value = newValue, !value.replacingOccurrences(of: " ", with: "").isEmpty {
                tagsLabel.text = "Tags: \(value)"
                tagsLabel.isHidden = false
            } else {
                tagsLabel.text = newValue
                tagsLabel.isHidden = true
            }
        }
    }
    
    var phone: String? {
        get {
            return phoneLabel.text
        }
        set {
            let number = cleansePhone(phoneNumber: newValue)
            print(number)
            phoneLabel.text = number
            phoneStack.isHidden = number == nil ? true : false
        }
    }
    
    var email: String? {
        get {
            return emailLabel.text
        }
        set {
            emailLabel.text = newValue
            emailStack.isHidden = newValue == nil ? true : false
        }
    }
    
    var petfinderWebsite: String? {
        get {
            return petfinderURL
        }
        set {
            petfinderURL = newValue
            petfinderWebsiteStack.isHidden = newValue == nil ? true : false
        }
    }
    
    var shelterWebsite: String? {
        get {
            return shelterURL
        }
        set {
            shelterURL = newValue
            shelterWebsiteStack.isHidden = newValue == nil ? true : false
        }
    }
    
    //MARK: - Setup Functions
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        setupLabels()
        setupHeaderStack()
        setupContentStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabels() {
        photoLabel = setupStandardLabel()
        nameLabel = setupStandardLabel(fontSize: Constants.AnimalDetail.NAME_FONT_SIZE)
        addressLabel = setupStandardLabel()
        cityStateLabel = setupStandardLabel()
        distanceLabel = setupStandardLabel()
        
        statusLabel = setupStandardLabel()
        typeLabel = setupStandardLabel()
        breedLabel = setupStandardLabel()
        colorLabel = setupStandardLabel()
        ageLabel = setupStandardLabel()
        genderLabel = setupStandardLabel()
        sizeLabel = setupStandardLabel()
        coatLabel = setupStandardLabel()
        attributesLabel = setupStandardLabel()
        environmentLabel = setupStandardLabel()
        tagsLabel = setupStandardLabel()
        
        phoneLabel = setupStandardLabel(labelIsHidden: false)
        emailLabel = setupStandardLabel(labelIsHidden: false)
        petfinderWebsiteLabel = setupStandardLabel(labelIsHidden: false, color: Constants.Colors.LINK_PURPLE, defaultText: "Petfinder Website")
        shelterWebsiteLabel = setupStandardLabel(labelIsHidden: false, color: Constants.Colors.LINK_PURPLE, defaultText: "Shelter Website")
    }
    
    func addImages(urls: [URL]) {
        guard !urls.isEmpty else { return }
        photoCount = urls.count
        photoLabel.text = "1 of \(photoCount)"
        
        imgScrollView.isHidden = false
        photoLabel.isHidden = false
        
        for url in urls {
            let img = ImageLoader()
            
            img.loadImage(url: url)
            
            img.contentMode = .scaleAspectFit
            img.clipsToBounds = true
            img.translatesAutoresizingMaskIntoConstraints = false
            
            imgStackView.addArrangedSubview(img)
            
            NSLayoutConstraint.activate([
                img.widthAnchor.constraint(equalTo: imgScrollView.widthAnchor),
                img.heightAnchor.constraint(equalTo: imgScrollView.heightAnchor)
            ])
        }
    }
    
    private func setupHeaderStack() {
        self.addSubview(headerVStack)
        imgScrollView.addSubview(imgStackView)
        
        headerVStack.addArrangedSubview(imgScrollView)
        headerVStack.addArrangedSubview(photoLabel)
        headerVStack.addArrangedSubview(nameLabel)
        headerVStack.addArrangedSubview(addressLabel)
        headerVStack.addArrangedSubview(cityStateLabel)
        headerVStack.addArrangedSubview(distanceLabel)
        headerVStack.addArrangedSubview(dividerBar)
        
        imgStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        NSLayoutConstraint.activate([
            headerVStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: HEADER_STACK_PADDING),
            headerVStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: HEADER_STACK_PADDING),
            headerVStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -HEADER_STACK_PADDING),
            imgScrollView.leadingAnchor.constraint(equalTo: headerVStack.leadingAnchor),
            imgScrollView.trailingAnchor.constraint(equalTo: headerVStack.trailingAnchor),
            imgScrollView.heightAnchor.constraint(equalToConstant: 150.0),
            imgStackView.topAnchor.constraint(equalTo: imgScrollView.topAnchor),
            imgStackView.leadingAnchor.constraint(equalTo: imgScrollView.leadingAnchor),
            imgStackView.bottomAnchor.constraint(equalTo: imgScrollView.bottomAnchor),
            imgStackView.trailingAnchor.constraint(equalTo: imgScrollView.trailingAnchor),
            dividerBar.leadingAnchor.constraint(equalTo: headerVStack.leadingAnchor),
            dividerBar.trailingAnchor.constraint(equalTo: headerVStack.trailingAnchor),
            dividerBar.heightAnchor.constraint(equalToConstant: 1.0)
        ])
    }
    
    private func setupContentStack() {
        phoneStack = generateIconStack(icon: .phone, label: phoneLabel)
        emailStack = generateIconStack(icon: .email, label: emailLabel)
        petfinderWebsiteStack = generateIconStack(icon: .website, label: petfinderWebsiteLabel)
        shelterWebsiteStack = generateIconStack(icon: .website, label: shelterWebsiteLabel)
        
        self.addSubview(contentScrollView)
        contentScrollView.addSubview(contentVStack)
        
        contentVStack.addArrangedSubview(statusLabel)
        contentVStack.addArrangedSubview(typeLabel)
        contentVStack.addArrangedSubview(breedLabel)
        contentVStack.addArrangedSubview(colorLabel)
        contentVStack.addArrangedSubview(ageLabel)
        contentVStack.addArrangedSubview(genderLabel)
        contentVStack.addArrangedSubview(sizeLabel)
        contentVStack.addArrangedSubview(coatLabel)
        contentVStack.addArrangedSubview(attributesLabel)
        contentVStack.addArrangedSubview(environmentLabel)
        contentVStack.addArrangedSubview(tagsLabel)
        
        contentVStack.addArrangedSubview(phoneStack)
        contentVStack.addArrangedSubview(emailStack)
        contentVStack.addArrangedSubview(petfinderWebsiteStack)
        contentVStack.addArrangedSubview(shelterWebsiteStack)
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: headerVStack.bottomAnchor, constant: HEADER_STACK_PADDING),
            contentScrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: HEADER_STACK_PADDING),
            contentScrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -HEADER_STACK_PADDING),
            contentScrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -HEADER_STACK_PADDING),
            contentVStack.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentVStack.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentVStack.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            //contentVStack.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            contentVStack.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor)
        ])
    }
    
    func updateImageCount(numbered: Int) {
        photoLabel.text = "\(numbered + 1) of \(photoCount)"
    }
    
    func addGesture(stack: DetailStacks, gesture: UITapGestureRecognizer) {
        switch stack {
        case .phone:
            print("adding phone gesture")
            phoneStack.addGestureRecognizer(gesture)
        case .email:
            emailStack.addGestureRecognizer(gesture)
        case .petfinderWebsite:
            petfinderWebsiteStack.addGestureRecognizer(gesture)
        case .shelterWebsite:
            shelterWebsiteStack.addGestureRecognizer(gesture)
        }
    }
}
