//
//  HomepageView.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/23/22.
//

import UIKit

protocol HomeViewDelegate {
    func buttonPressed(_ button: UIButton)
}

class HomepageView: UIView {
    var delegate: HomeViewDelegate?
    
    private var findAnimalButton: UIButton!
    private var animalsText: UILabel!
    private var findShelterButton: UIButton!
    private var shelterText: UILabel!
    
    private let appLogo: UIImageView = {
        let imgView = UIImageView()
        
        guard let image = UIImage(named: Constants.Images.APP_NAME_LOGO) else { fatalError("'appLogo' not initialized with image") }
        imgView.image = image
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        return imgView
    }()
    
    private let logoText: UILabel = {
        let label = UILabel()
        
        label.text = Constants.WelcomePage.TITLE_SUBTEXT
        if let color = UIColor(named: Constants.Colors.LOGO_TEXT_GREY) { label.textColor = color }
        if let font = UIFont(name: Constants.Fonts.OPEN_SANS, size: Constants.WelcomePage.SUBTITLE_FONT) { label.font = font }
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        initializeVariables()
        setupLogo()
        setupAnimalButton()
        setupShelterButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeVariables() {
        findAnimalButton = setupButton(imageName: Constants.Images.DOG_ICON, tag: 1)
        animalsText = setupTextLabel(text: Constants.WelcomePage.ANIMAL_TITLE)
        findShelterButton = setupButton(imageName: Constants.Images.SHELTER_ICON, tag: 0)
        shelterText = setupTextLabel(text: Constants.WelcomePage.SHELTER_TITLE)
    }
    
    private func setupLogo() {
        self.addSubview(appLogo)
        self.addSubview(logoText)
        
        NSLayoutConstraint.activate([
            appLogo.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            appLogo.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            logoText.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 15),
            logoText.centerXAnchor.constraint(equalTo: appLogo.centerXAnchor)
        ])
    }
    
    private func setupAnimalButton() {
        findAnimalButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.addSubview(findAnimalButton)
        self.addSubview(animalsText)
        
        let buttonYAnchor = NSLayoutConstraint(item: findAnimalButton!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 0.45, constant: 0)
    
        NSLayoutConstraint.activate([
            buttonYAnchor,
            findAnimalButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            animalsText.topAnchor.constraint(equalTo: findAnimalButton.bottomAnchor, constant: 5),
            animalsText.centerXAnchor.constraint(equalTo: findAnimalButton.centerXAnchor)
        ])
    }
    
    private func setupShelterButton() {
        findShelterButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.addSubview(findShelterButton)
        self.addSubview(shelterText)
        
        NSLayoutConstraint.activate([
            findShelterButton.topAnchor.constraint(equalTo: findAnimalButton.bottomAnchor, constant: 60),
            findShelterButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            shelterText.topAnchor.constraint(equalTo: findShelterButton.bottomAnchor, constant: 5),
            shelterText.centerXAnchor.constraint(equalTo: findShelterButton.centerXAnchor)
        ])
    }
}


//    MARK: - Helper Functions

extension HomepageView {
    private func setupTextLabel(text: String) -> UILabel {
        let label = UILabel()
        
        label.text = text
        label.textColor = UIColor(named: Constants.Colors.DARK_GREY)
        label.font = UIFont(name: Constants.Fonts.OPEN_SANS, size: Constants.WelcomePage.BUTTON_TITLE_FONT)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    private func setupButton(imageName: String, tag: Int) -> UIButton {
        guard let image = UIImage(named: imageName) else { fatalError() }
        let button = UIButton()
        
        button.tag = tag
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}


//    MARK: - Delegate Functions

extension HomepageView {
    @objc private func buttonPressed(sender: UIButton) {
        delegate?.buttonPressed(sender)
    }
}
