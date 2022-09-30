//
//  ShelterDetailViewController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 9/26/22.
//

import UIKit

class ShelterDetailViewController: UIViewController {
    let shelterInfo: Shelter
    
    init(shelter: Shelter) {
        self.shelterInfo = shelter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shelterView = ShelterDetailView()
        shelterView.imgScrollView.delegate = self
        self.view = shelterView
        
        retrieveImages()
        setupNavigationController()
        assignShelterValues()
    }
    
    private func retrieveImages() {
        let photos = shelterInfo.photos
        guard let detailView = self.view as? ShelterDetailView, !photos.isEmpty else { return }
        
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
        let centerImage = UIImage(named: "Shelters.png")
        
        let leftImageAction = UIAction(title: "Back") { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", image: leftImage, primaryAction: leftImageAction, menu: nil)
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.titleView = UIImageView(image: centerImage)
        self.navigationController?.navigationBar.tintColor = .gray
    }
    
    private func assignShelterValues() {
        guard let detailView = self.view as? ShelterDetailView else { return }
        
        detailView.sheltername = shelterInfo.name
        detailView.address = shelterInfo.address?.address1
        detailView.cityState = generateCityStateText()
        detailView.distance = shelterInfo.distance == nil ? nil : "\(String(format: "%.2f", shelterInfo.distance!)) mi."
        
        detailView.phone = shelterInfo.phone
        detailView.email = shelterInfo.email
        detailView.petfinderWebsite = shelterInfo.url
        detailView.shelterWebsite = shelterInfo.website
    }
    
    private func generateCityStateText() -> String? {
        var cityStateString: String = ""

        if let city = shelterInfo.address?.city {
            cityStateString.append(city)
        }

        if let state = shelterInfo.address?.state {
            if !cityStateString.isEmpty { cityStateString.append(", ") }
            cityStateString.append(state)
        }
        
        if let postcode = shelterInfo.address?.postcode {
            if !cityStateString.isEmpty { cityStateString.append(", ") }
            cityStateString.append(postcode)
        }

        return cityStateString.isEmpty ? nil : cityStateString
    }

    
    
    
//    func addLabelValues() {

//
//        shelterDetailView.phoneNumber = shelterInfo?.phone
//        shelterDetailView.email = shelterInfo?.email
//        shelterDetailView.petfinderWebsite = shelterInfo?.url
//        shelterDetailView.shelterWebsite = shelterInfo?.website
//        shelterDetailView.facebook = shelterInfo?.social_media?.facebook
//        shelterDetailView.twitter = shelterInfo?.social_media?.twitter
//        shelterDetailView.youtube = shelterInfo?.social_media?.youtube
//        shelterDetailView.instagram = shelterInfo?.social_media?.instagram
//        shelterDetailView.pinterest = shelterInfo?.social_media?.pinterest
//    }
//
//    private func cleansePhoneNumber(_ phoneNumber: String?) -> String? {
//        let cleansedNumber = phoneNumber
//
//        if phoneNumber?.rangeOfCharacter(from: .letters) != nil { return nil }
//        if phoneNumber?.rangeOfCharacter(from: .decimalDigits) == nil { return nil }
//
//        return cleansedNumber
//    }
//
//    func addGestureRecognizers() {
//        let phoneGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPhoneView(_:)))
//        shelterDetailView.phoneStack.addGestureRecognizer(phoneGesture)
//
//        let emailGesture = UITapGestureRecognizer(target: self, action: #selector(didTapEmail(_:)))
//        shelterDetailView.emailStack.addGestureRecognizer(emailGesture)
//
//        let petfinderGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPetfinderWebsite(_:)))
//        let websiteGesture = UITapGestureRecognizer(target: self, action: #selector(didTapWebsite(_:)))
//        shelterDetailView.petfinderWebsiteStack.addGestureRecognizer(petfinderGesture)
//        shelterDetailView.shelterWebsiteStack.addGestureRecognizer(websiteGesture)
//
//        let fbGesture = UITapGestureRecognizer(target: self, action: #selector(didTapFacebook(_:)))
//        shelterDetailView.facebookIcon.addGestureRecognizer(fbGesture)
//
//        let twitterGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTwitter(_:)))
//        shelterDetailView.twitterIcon.addGestureRecognizer(twitterGesture)
//
//        let youtubeGesture = UITapGestureRecognizer(target: self, action: #selector(didTapYoutube(_:)))
//        shelterDetailView.youtubeIcon.addGestureRecognizer(youtubeGesture)
//
//        let instagramGesture = UITapGestureRecognizer(target: self, action: #selector(didTapInstagram(_:)))
//        shelterDetailView.instagramIcon.addGestureRecognizer(instagramGesture)
//
//        let pinterestGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPinterest(_:)))
//        shelterDetailView.pinterestIcon.addGestureRecognizer(pinterestGesture)
//    }
}

extension ShelterDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let detailView = self.view as? ShelterDetailView else { return }

        detailView.updateImageCount(numbered: Int(scrollView.contentOffset.x/scrollView.frame.size.width))
    }
}
