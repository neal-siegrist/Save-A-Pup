//
//  AnimalCell.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/26/22.
//

import UIKit

class AnimalCell: UITableViewCell {
    
    static let CELL_IDENTIFIER: String = "animalCell"
    
    private static let DISTANCE_LABEL_WIDTH: CGFloat = 45.0
    private static let HORIZONTAL_PADDING: CGFloat = 15.0
    private static let IMAGE_PADDING: CGFloat = 5.0
    private static let IMAGE_SIZE: CGFloat = 70.0
    private static let TOP_BOTTOM_PADDING: CGFloat = 5.0
    
    
    var ageLabel: UILabel!
    var breedLabel: UILabel!
    var cityStateLabel: UILabel!
    var genderLabel: UILabel!
    var nameLabel: UILabel!
    
    let animalImageView: ImageLoader = {
        let imgView = ImageLoader()
        
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = IMAGE_SIZE / 2
        imgView.layer.borderWidth = 0.5
        imgView.layer.borderColor = CGColor(red: 0.69, green: 0.73, blue: 0.78, alpha: 1.0)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        return imgView
    }()
    
    private let labelContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.textAlignment = .center
        distanceLabel.font = UIFont(name: Constants.Fonts.OPEN_SANS_BOLD, size: Constants.AnimalCell.DISTANCE_FONT_SIZE)
        distanceLabel.numberOfLines = 0
        return distanceLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initializeVariables()
        setupConstraints()
        setupCellBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeVariables() {
        nameLabel = setupLabel(font: Constants.Fonts.OPEN_SANS, textSize: Constants.AnimalCell.MAIN_FONT_SIZE, color: Constants.Colors.DARK_GREY)
        breedLabel = setupLabel(font: Constants.Fonts.OPEN_SANS_SEMIBOLD, textSize: Constants.AnimalCell.SUB_FONT_SIZE, color: Constants.Colors.LOGO_TEXT_GREY)
        ageLabel = setupLabel(font: Constants.Fonts.OPEN_SANS_SEMIBOLD, textSize: Constants.AnimalCell.SUB_FONT_SIZE, color: Constants.Colors.LOGO_TEXT_GREY)
        genderLabel = setupLabel(font: Constants.Fonts.OPEN_SANS_SEMIBOLD, textSize: Constants.AnimalCell.SUB_FONT_SIZE, color: Constants.Colors.LOGO_TEXT_GREY)
        cityStateLabel = setupLabel(font:  Constants.Fonts.OPEN_SANS_SEMIBOLD, textSize: Constants.AnimalCell.SUB_FONT_SIZE, color: Constants.Colors.LOGO_TEXT_GREY)
    }
    
    private func setupConstraints() {
        addSubviews()
        
        setupImageConstraints()
        setupDistanceLabelConstraints()
        
        setupLabelContainerViewConstraints()
        setupNameLabelConstraints()
        setupBreedLabelConstraints()
        setupAgeLabelConstraints()
        setupGenderLabelConstraints()
        setupCityStateLabelConstraints()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(animalImageView)
        self.contentView.addSubview(distanceLabel)
        self.contentView.addSubview(labelContainerView)
        labelContainerView.addSubview(nameLabel)
        labelContainerView.addSubview(breedLabel)
        labelContainerView.addSubview(ageLabel)
        labelContainerView.addSubview(genderLabel)
        labelContainerView.addSubview(cityStateLabel)
    }
    
    private func setupImageConstraints() {
        let topAnchor = animalImageView.topAnchor.constraint(greaterThanOrEqualTo: self.contentView.topAnchor, constant: AnimalCell.TOP_BOTTOM_PADDING)
        let bottomAnchor = animalImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -AnimalCell.TOP_BOTTOM_PADDING)

        topAnchor.priority = UILayoutPriority(rawValue: 999)
        bottomAnchor.priority = UILayoutPriority(rawValue: 999)
        
        NSLayoutConstraint.activate([
            animalImageView.widthAnchor.constraint(equalToConstant: AnimalCell.IMAGE_SIZE),
            animalImageView.heightAnchor.constraint(equalToConstant: AnimalCell.IMAGE_SIZE),
            animalImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: AnimalCell.HORIZONTAL_PADDING),
            animalImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            topAnchor,
            bottomAnchor
        ])
    }
    
    private func setupDistanceLabelConstraints() {
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: AnimalCell.TOP_BOTTOM_PADDING),
            distanceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -AnimalCell.TOP_BOTTOM_PADDING),
            distanceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -AnimalCell.HORIZONTAL_PADDING),
            distanceLabel.widthAnchor.constraint(equalToConstant: AnimalCell.DISTANCE_LABEL_WIDTH)
        ])
    }
    
    private func setupLabelContainerViewConstraints() {
        NSLayoutConstraint.activate([
            labelContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: AnimalCell.TOP_BOTTOM_PADDING),
            labelContainerView.leadingAnchor.constraint(equalTo: animalImageView.trailingAnchor, constant: AnimalCell.HORIZONTAL_PADDING),
            labelContainerView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -AnimalCell.TOP_BOTTOM_PADDING),
            labelContainerView.trailingAnchor.constraint(equalTo: distanceLabel.leadingAnchor, constant: -AnimalCell.HORIZONTAL_PADDING)
        ])
    }
    
    private func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: labelContainerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: breedLabel.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor)
        ])
    }
    
    private func setupBreedLabelConstraints() {
        NSLayoutConstraint.activate([
            breedLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            breedLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor),
            breedLabel.bottomAnchor.constraint(equalTo: ageLabel.topAnchor),
            breedLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor)
        ])
    }
    
    func setupAgeLabelConstraints() {
        NSLayoutConstraint.activate([
            ageLabel.topAnchor.constraint(equalTo: breedLabel.bottomAnchor),
            ageLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor),
            ageLabel.bottomAnchor.constraint(equalTo: genderLabel.topAnchor),
            ageLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor)
        ])
    }
    
    private func setupGenderLabelConstraints() {
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor),
            genderLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor),
            genderLabel.bottomAnchor.constraint(equalTo: cityStateLabel.topAnchor),
            genderLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor)
        ])
    }
    
    private func setupCityStateLabelConstraints() {
        NSLayoutConstraint.activate([
            cityStateLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor),
            cityStateLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor),
            cityStateLabel.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor),
            cityStateLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor)
        ])
    }
    
    private func setupCellBorder() {
        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = CGColor(red: 0.69, green: 0.73, blue: 0.78, alpha: 100.0)
    }
}

// MARK: - Helper Functions

extension AnimalCell {
    private func setupLabel(font: String, textSize: CGFloat, color: String) -> UILabel {
        let label = UILabel()
        
        label.font = UIFont(name: font, size: textSize)
        label.textColor = UIColor(named: color)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    func resetContent() {
        self.animalImageView.image = nil
        self.nameLabel.text = nil
        self.breedLabel.text = nil
        self.ageLabel.text = nil
        self.ageLabel.text = nil
        self.genderLabel.text = nil
        self.cityStateLabel.text = nil
        self.distanceLabel.text = nil
    }
    
    //Override for cell attribute setup
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//    }
}
