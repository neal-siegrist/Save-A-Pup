//
//  DetailView.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 10/3/22.
//

import UIKit

class DetailView: UIView {
    
    func setupStandardLabel(fontSize: CGFloat = 12, labelIsHidden: Bool = true, color: String = Constants.Colors.DARK_GREY, defaultText: String? = nil) -> UILabel {
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
    
    func generateIconStack(icon: ContactIcons, label: UILabel) -> UIStackView {
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
    
    func generateIcon(icon: ContactIcons) -> UIImageView {
        let phoneIcon = UIImageView()
        phoneIcon.image = UIImage(systemName: icon.rawValue)
        phoneIcon.contentMode = .scaleAspectFit
        phoneIcon.tintColor = .gray
        phoneIcon.translatesAutoresizingMaskIntoConstraints = false
        return phoneIcon
    }
    
    func cleansePhone(phoneNumber: String?) -> String? {
    
        guard phoneNumber?.rangeOfCharacter(from: .letters) == nil, phoneNumber?.rangeOfCharacter(from: .decimalDigits) != nil else { return nil }
        
        return phoneNumber
    }
    
}
