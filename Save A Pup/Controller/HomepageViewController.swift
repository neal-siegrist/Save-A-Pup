//
//  HomepageViewController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/23/22.
//

import UIKit

class HomepageViewController: UIViewController {

    private let SHELTER_SELECTION = 0
    private let ANIMAL_SELECTION = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let homepageView = HomepageView(frame: .zero)
        self.view = homepageView
        homepageView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension HomepageViewController: HomeViewDelegate {
    func buttonPressed(_ button: UIButton) {
        if button.tag == SHELTER_SELECTION {
            navigationController?.pushViewController(ShelterResultsViewController(viewType: .shelterView), animated: true)
        } else if button.tag == ANIMAL_SELECTION {
            navigationController?.pushViewController(AnimalResultsViewController(viewType: .animalView), animated: true)
        }
    }
}
