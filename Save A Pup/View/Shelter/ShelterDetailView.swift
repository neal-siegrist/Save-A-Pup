//
//  ShelterDetailView.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/26/22.
//

import UIKit

class ShelterDetailView: UIView {
    
    private enum Icons: String {
        case phone
        case email = "envelope"
        case website = "globe"
    }
    
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
    private var phoneLabel, emailLabel, petfinderWebsiteLabel, shelterWebsiteLabel: UILabel!
    private var phoneStack, emailStack, petfinderWebsiteStack, shelterWebsiteStack: UIStackView!
    private var petfinderURL, shelterURL: String?
    
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
    
    var sheltername: String? {
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
    
    var phone: String? {
        get {
            return phoneLabel.text
        }
        set {
            let number = cleansePhone(phoneNumber: newValue)
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
        
        self.addSubview(contentVStack)
        
        contentVStack.addArrangedSubview(phoneStack)
        contentVStack.addArrangedSubview(emailStack)
        contentVStack.addArrangedSubview(petfinderWebsiteStack)
        contentVStack.addArrangedSubview(shelterWebsiteStack)
        
        NSLayoutConstraint.activate([
            contentVStack.topAnchor.constraint(equalTo: headerVStack.bottomAnchor, constant: HEADER_STACK_PADDING),
            contentVStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: HEADER_STACK_PADDING),
            contentVStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -HEADER_STACK_PADDING)
        ])
    }
    
    func updateImageCount(numbered: Int) {
        photoLabel.text = "\(numbered + 1) of \(photoCount)"
    }
}

extension ShelterDetailView {
    
    private func setupStandardLabel(fontSize: CGFloat = 12, labelIsHidden: Bool = true, color: String = Constants.Colors.DARK_GREY, defaultText: String? = nil) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: Constants.Fonts.OPEN_SANS_BOLD, size: fontSize)
        label.textColor = UIColor(named: color)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = labelIsHidden
        label.text = defaultText
        return label
    }
    
    private func generateIconStack(icon: Icons, label: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 5.0
        stack.isUserInteractionEnabled = true
        stack.isHidden = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(generateIcon(icon: icon))
        stack.addArrangedSubview(label)
        
        return stack
    }
    
    private func generateIcon(icon: Icons) -> UIImageView {
        let phoneIcon = UIImageView()
        phoneIcon.image = UIImage(systemName: icon.rawValue)
        phoneIcon.contentMode = .scaleAspectFit
        phoneIcon.tintColor = .gray
        phoneIcon.translatesAutoresizingMaskIntoConstraints = false
        return phoneIcon
    }
    
    private func cleansePhone(phoneNumber: String?) -> String? {
    
        guard phoneNumber?.rangeOfCharacter(from: .letters) == nil, phoneNumber?.rangeOfCharacter(from: .decimalDigits) != nil else { return nil }
        
        return phoneNumber
    }
}
