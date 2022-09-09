//
//  HomepageViewController.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/23/22.
//

import UIKit

class HomepageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = HomepageView(frame: .zero)
        self.view = view
        view.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension HomepageViewController: HomeViewDelegate {
    func buttonPressed(_ button: UIButton) {
        if button.tag == 0 {
            navigationController?.pushViewController(ShelterResultsViewController(viewType: .shelterView), animated: true)
        } else if button.tag == 1 {
            navigationController?.pushViewController(AnimalResultsViewController(viewType: .animalView), animated: true)
        }
    }
}
