//
//  ShelterCell.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/30/22.
//

import UIKit

class ShelterCell: UITableViewCell {
    
    static let CELL_IDENTIFIER: String = "shelterCell"
    
    private static let DISTANCE_LABEL_WIDTH: CGFloat = 45.0
    private static let HORIZONTAL_PADDING: CGFloat = 15.0
    private static let TOP_BOTTOM_PADDING: CGFloat = 5.0
    
    var addressLabel, cityStateLabel, nameLabel: UILabel!
    
    let labelContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let distanceLabel: UILabel = {
        let distanceLabel = UILabel()
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.textAlignment = .center
        distanceLabel.font = UIFont(name: Constants.Fonts.OPEN_SANS_BOLD, size: Constants.ShelterCell.DISTANCE_FONT_SIZE)
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
        nameLabel = setupLabel(font: Constants.Fonts.OPEN_SANS_BOLD, textSize: Constants.ShelterCell.MAIN_FONT_SIZE, color: Constants.Colors.DARK_GREY)
        addressLabel = setupLabel(font: Constants.Fonts.OPEN_SANS_SEMIBOLD, textSize: Constants.ShelterCell.SUB_FONT_SIZE, color: Constants.Colors.LOGO_TEXT_GREY)
        cityStateLabel = setupLabel(font: Constants.Fonts.OPEN_SANS_SEMIBOLD, textSize: Constants.ShelterCell.SUB_FONT_SIZE, color: Constants.Colors.LOGO_TEXT_GREY)
    }
    
    private func setupConstraints() {
        addSubviews()
        
        setupDistanceLabelConstraints()
        
        setupLabelContainerViewConstraints()
        setupNameLabelConstraints()
        setupAddressLabelConstraints()
        setupCityStateLabelConstraints()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(distanceLabel)
        self.contentView.addSubview(labelContainerView)
        labelContainerView.addSubview(nameLabel)
        labelContainerView.addSubview(addressLabel)
        labelContainerView.addSubview(cityStateLabel)
    }
    
    func setupDistanceLabelConstraints() {
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: ShelterCell.TOP_BOTTOM_PADDING),
            distanceLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -ShelterCell.TOP_BOTTOM_PADDING),
            distanceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -ShelterCell.HORIZONTAL_PADDING),
            distanceLabel.widthAnchor.constraint(equalToConstant: ShelterCell.DISTANCE_LABEL_WIDTH)
        ])
    }
    
    private func setupLabelContainerViewConstraints() {
        NSLayoutConstraint.activate([
            labelContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: ShelterCell.TOP_BOTTOM_PADDING),
            labelContainerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: ShelterCell.HORIZONTAL_PADDING),
            labelContainerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -ShelterCell.TOP_BOTTOM_PADDING),
            labelContainerView.trailingAnchor.constraint(equalTo: distanceLabel.leadingAnchor, constant: -ShelterCell.HORIZONTAL_PADDING)
        ])
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: labelContainerView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: addressLabel.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor)
        ])
    }

    func setupAddressLabelConstraints() {
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: cityStateLabel.topAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor)
        ])
    }

    func setupCityStateLabelConstraints() {
        NSLayoutConstraint.activate([
            cityStateLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor),
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

extension ShelterCell {
    private func setupLabel(font: String, textSize: CGFloat, color: String) -> UILabel {
        let label = UILabel()
        
        label.font = UIFont(name: font, size: textSize)
        label.textColor = UIColor(named: color)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}
