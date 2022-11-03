//
//  AnimalSearchController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 10/5/22.
//

import UIKit
import CoreLocation

class AnimalSearchController: UIViewController {
    
    var animalsVC: AnimalResultsViewController
    var searchViewSheet: AnimalSearchView
    var currentTextField: UITextField?
    var locationData: LocationData?
    
    init(animalVC: AnimalResultsViewController) {
        self.animalsVC = animalVC
        self.searchViewSheet = AnimalSearchView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = searchViewSheet
        
        setupNavigationController()
        
        setAnimalViewDelegates()
        searchViewSheet.pickerView.delegate = self
        searchViewSheet.pickerView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        configureSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.endEditing(true)
    }
    
    private func setupNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Animal Search"
        
        let leftImage = UIImage(named: "LeftBarCross.png")
        
        let leftImageAction = UIAction(title: "Back") { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: leftImage, primaryAction: leftImageAction, menu: nil)
        
        self.navigationController?.navigationBar.tintColor = .gray
    }
    
    private func configureSearchButton() {
        let button = searchViewSheet.searchButton
        button.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
    }
    
    @objc func searchPressed(_ button: UIButton) {
        let searchCriteria = animalsVC.animalsWrapper.urlBuilder
        
        searchCriteria.clearParameters()
        
        //Process Type
        if let typeText = searchViewSheet.typeSearchBar.text {
            if let parsedText = parseSelectedValue(typeText), parsedText != "All" {
                searchCriteria.addParameter(parameterName: .type, paramaterValue: parsedText)
            }
        }
        
        //Process Breed
        if let breedText = searchViewSheet.breedSearchBar.text {
            if let parsedText = parseSelectedValue(breedText), parsedText != "All", parsedText != "n/a" {
                searchCriteria.addParameter(parameterName: .breed, paramaterValue: parsedText)
            }
        }
        
        //Process Size
        if let sizeText = searchViewSheet.sizeSearchBar.text {
            if let parsedText = parseSelectedValue(sizeText), parsedText != "All", parsedText != "n/a" {
                searchCriteria.addParameter(parameterName: .size, paramaterValue: parsedText)
            }
        }
        
        //Process Gender
        if let genderText = searchViewSheet.genderSearchBar.text {
            if let parsedText = parseSelectedValue(genderText), parsedText != "All", parsedText != "n/a" {
                searchCriteria.addParameter(parameterName: .gender, paramaterValue: parsedText)
            }
        }
        
        //Process Age
        if let ageText = searchViewSheet.ageSearchBar.text {
            if let parsedText = parseSelectedValue(ageText), parsedText != "All", parsedText != "n/a" {
                searchCriteria.addParameter(parameterName: .age, paramaterValue: parsedText)
            }
        }
        
        //Process Color
        if let colorText = searchViewSheet.colorSearchBar.text {
            if let parsedText = parseSelectedValue(colorText), parsedText != "All", parsedText != "n/a" {
                searchCriteria.addParameter(parameterName: .color, paramaterValue: parsedText)
            }
        }
        
        //Process Coat
        if let coatText = searchViewSheet.coatSearchBar.text {
            if let parsedText = parseSelectedValue(coatText), parsedText != "All", parsedText != "n/a" {
                searchCriteria.addParameter(parameterName: .coat, paramaterValue: parsedText)
            }
        }
        
        //Process Status
        if let statusText = searchViewSheet.statusSearchBar.text {
            if let parsedText = parseSelectedValue(statusText), parsedText != "All", parsedText != "n/a" {
                searchCriteria.addParameter(parameterName: .status, paramaterValue: parsedText)
            }
        }
        
        //Process Location
        if let locationText = searchViewSheet.locationSearchBar.text, !locationText.isEmpty {
            if locationText == "Current Location" {
                searchCriteria.addParameter(parameterName: .location, paramaterValue: "\(LocationManager.shared.location.coordinate.latitude),\(LocationManager.shared.location.coordinate.longitude)")
    
            } else {
                guard let locationData = locationData else { return }
                
                searchCriteria.addParameter(parameterName: .location, paramaterValue: "\(locationData.coordinates.latitude),\(locationData.coordinates.longitude)")
            }
        }
        
        animalsVC.updateResults()
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset: UIEdgeInsets = searchViewSheet.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 40
        searchViewSheet.scrollView.contentInset = contentInset
        
        if let textField = currentTextField {
            searchViewSheet.scrollView.scrollRectToVisible(textField.frame, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        searchViewSheet.scrollView.contentInset = contentInset
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnimalViewDelegates() {
        searchViewSheet.typeSearchBar.delegate = self
        searchViewSheet.breedSearchBar.delegate = self
        searchViewSheet.sizeSearchBar.delegate = self
        searchViewSheet.genderSearchBar.delegate = self
        searchViewSheet.ageSearchBar.delegate = self
        searchViewSheet.colorSearchBar.delegate = self
        searchViewSheet.coatSearchBar.delegate = self
        searchViewSheet.statusSearchBar.delegate = self
        searchViewSheet.locationSearchBar.delegate = self
    }
}

extension AnimalSearchController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.tag == 8
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 8 {
            searchViewSheet.typeSearchBar.resignFirstResponder()
            searchViewSheet.breedSearchBar.resignFirstResponder()
            searchViewSheet.sizeSearchBar.resignFirstResponder()
            searchViewSheet.genderSearchBar.resignFirstResponder()
            searchViewSheet.ageSearchBar.resignFirstResponder()
            searchViewSheet.colorSearchBar.resignFirstResponder()
            searchViewSheet.coatSearchBar.resignFirstResponder()
            searchViewSheet.statusSearchBar.resignFirstResponder()
            navigationController?.pushViewController(LocationSearchController(searchVC: self), animated: true)
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currentTextField = textField
        
        if textField.tag != 8 {
            searchViewSheet.pickerView.reloadAllComponents()
            
            let selectedRow = getSelectionRow() ?? 0
            searchViewSheet.pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
            
            if let textField = currentTextField {
                searchViewSheet.scrollView.scrollRectToVisible(textField.frame, animated: true)
            }
        } else {
            let searchVC = LocationSearchController(searchVC: self)
            navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    private func getSelectionRow() -> Int? {
        guard let currTag = currentTextField?.tag else { return 0 }
        guard let currText = currentTextField?.text else { return 0 }
        guard let currType = searchViewSheet.typeSearchBar.text else { return 0 }
        let type = parseSelectedValue(currType)!
        let text = parseSelectedValue(currText)!
        
        switch currTag {
        case 0:
            return PickerOptions.getAnimalTypes()?.firstIndex(of: type)
        case 1:
            guard let breeds = PickerOptions.getBreeds(animalType: type) else { return 0 }
            return breeds.firstIndex(of: text)
        case 2:
            return PickerOptions.getSizes().firstIndex(of: text)
        case 3:
            guard let genders = PickerOptions.getGenders(animalType: type) else { return 0 }
            return genders.firstIndex(of: text)
        case 4:
            return PickerOptions.getAges().firstIndex(of: text)
        case 5:
            guard let colors = PickerOptions.getColors(animalType: type) else { return 0 }
            return colors.firstIndex(of: text)
        case 6:
            guard let coats = PickerOptions.getCoats(animalType: type) else { return 0 }
            return coats.firstIndex(of: text)
        case 7:
            return PickerOptions.getStatus().firstIndex(of: text)
        default:
            return 0
        }
    }
}

extension AnimalSearchController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let currTag = currentTextField?.tag else { return 0 }
        
        switch currTag {
        case 0:
            guard let animals = PickerOptions.getAnimalTypes() else { return 0 }
            return animals.count
        case 1:
            let animalType = searchViewSheet.typeSearchBar.text ?? "All"
            guard let parsedType = parseSelectedValue(animalType) else { return 0 }
            guard let breeds = PickerOptions.getBreeds(animalType: parsedType) else { return 0 }
            return breeds.count
        case 2:
            return PickerOptions.getSizes().count
        case 3:
            let animalType = searchViewSheet.typeSearchBar.text ?? "All"
            guard let parsedType = parseSelectedValue(animalType) else { return 0 }
            guard let genders = PickerOptions.getGenders(animalType: parsedType) else { return 0 }
            return genders.count
        case 4:
            return PickerOptions.getAges().count
        case 5:
            let animalType = searchViewSheet.typeSearchBar.text ?? "All"
            guard let parsedType = parseSelectedValue(animalType) else { return 0 }
            guard let colors = PickerOptions.getColors(animalType: parsedType) else { return 0 }
            return colors.count
        case 6:
            let animalType = searchViewSheet.typeSearchBar.text ?? "All"
            guard let parsedType = parseSelectedValue(animalType) else { return 0 }
            guard let coats = PickerOptions.getCoats(animalType: parsedType) else { return 0 }
            return coats.count
        case 7:
            return PickerOptions.getStatus().count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let currTag = currentTextField?.tag else { return nil }
        
        switch currTag {
        case 0:
            guard let animals = PickerOptions.getAnimalTypes() else { return nil }
            return animals[row]
        case 1:
            let animalType = searchViewSheet.typeSearchBar.text ?? "All"
            guard let parsedType = parseSelectedValue(animalType) else { return nil }
            guard let breeds = PickerOptions.getBreeds(animalType: parsedType) else { return nil }
            return breeds[row]
        case 2:
            return PickerOptions.getSizes()[row]
        case 3:
            let animalType = searchViewSheet.typeSearchBar.text ?? "All"
            guard let parsedType = parseSelectedValue(animalType) else { return nil }
            guard let genders = PickerOptions.getGenders(animalType: parsedType) else { return nil }
            return genders[row]
        case 4:
            return PickerOptions.getAges()[row]
        case 5:
            let animalType = searchViewSheet.typeSearchBar.text ?? "All"
            guard let parsedType = parseSelectedValue(animalType) else { return nil }
            guard let colors = PickerOptions.getColors(animalType: parsedType) else { return nil }
            return colors[row]
        case 6:
            let animalType = searchViewSheet.typeSearchBar.text ?? "All"
            guard let parsedType = parseSelectedValue(animalType) else { return nil }
            guard let coats = PickerOptions.getCoats(animalType: parsedType) else { return nil }
            return coats[row]
        case 7:
            return PickerOptions.getStatus()[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let currTag = currentTextField?.tag else { return }
        
        switch currTag {
        case 0:
            guard let animals = PickerOptions.getAnimalTypes() else{ break }
            searchViewSheet.typeSearchBar.text = "Type: \(animals[row])"
            processTypeSelection(animalType: animals[row])
        case 1:
            let animalType = searchViewSheet.typeSearchBar.text ?? ""
            guard let parsedType = parseSelectedValue(animalType) else { return }
            guard let breeds = PickerOptions.getBreeds(animalType: parsedType) else{ return }
            searchViewSheet.breedSearchBar.text = "Breed: \(breeds[row])"
        case 2:
            let sizes = PickerOptions.getSizes()
            searchViewSheet.sizeSearchBar.text = "Size: \(sizes[row])"
        case 3:
            let animalType = searchViewSheet.typeSearchBar.text ?? "All"
            guard let parsedType = parseSelectedValue(animalType) else { return }
            guard let genders = PickerOptions.getGenders(animalType: parsedType) else { return }
            searchViewSheet.genderSearchBar.text = "Gender: \(genders[row])"
        case 4:
            let ages = PickerOptions.getAges()
            searchViewSheet.ageSearchBar.text = "Age: \(ages[row])"
        case 5:
            let animalType = searchViewSheet.typeSearchBar.text ?? ""
            guard let parsedType = parseSelectedValue(animalType) else { return }
            guard let colors = PickerOptions.getColors(animalType: parsedType) else{ return }
            searchViewSheet.colorSearchBar.text = "Color: \(colors[row])"
        case 6:
            let animalType = searchViewSheet.typeSearchBar.text ?? ""
            guard let parsedType = parseSelectedValue(animalType) else { return }
            guard let coats = PickerOptions.getCoats(animalType: parsedType) else{ return }
            searchViewSheet.coatSearchBar.text = "Color: \(coats[row])"
        case 7:
            let status = PickerOptions.getStatus()
            searchViewSheet.statusSearchBar.text = "Status: \(status[row])"
        default:
            print("default case")
        }
    }
    
    private func parseSelectedValue(_ selectedString: String) -> String? {
        let firstSpaceIndex = selectedString.firstIndex(of: " ") ?? selectedString.endIndex
        
        if firstSpaceIndex != selectedString.endIndex {
            let startIndex = selectedString.index(after: firstSpaceIndex)
            return String(selectedString[startIndex...])
        }
        
        return nil
    }
    
    private func processTypeSelection(animalType: String) {
        let isAll = animalType != "All"
        
        searchViewSheet.genderSearchBar.text = "Gender: All"
        searchViewSheet.breedSearchBar.text = "Breed: All"
        searchViewSheet.colorSearchBar.text = "Color: All"
        
        searchViewSheet.coatSearchBar.text = "Coat: All"
        
        searchViewSheet.genderSearchBar.isUserInteractionEnabled = isAll
        searchViewSheet.genderSearchBar.backgroundColor = isAll ? .white : .lightGray
        
        searchViewSheet.breedSearchBar.isUserInteractionEnabled = isAll
        searchViewSheet.breedSearchBar.backgroundColor = isAll ? .white : .lightGray
        
        searchViewSheet.colorSearchBar.isUserInteractionEnabled = isAll
        searchViewSheet.colorSearchBar.backgroundColor = isAll ? .white : .lightGray
        
        searchViewSheet.coatSearchBar.isUserInteractionEnabled = isAll
        searchViewSheet.coatSearchBar.backgroundColor = isAll ? .white : .lightGray
        
        let type = searchViewSheet.typeSearchBar.text!
        let parsedType = parseSelectedValue(type) ?? "All"
        if parsedType.contains("Horse") || parsedType.contains("Bird") || parsedType.contains("Scales, Fins & Other") {
            searchViewSheet.coatSearchBar.text = "Coat: n/a"
            searchViewSheet.coatSearchBar.isUserInteractionEnabled = false
            searchViewSheet.coatSearchBar.backgroundColor = .lightGray
        }
    }
}
