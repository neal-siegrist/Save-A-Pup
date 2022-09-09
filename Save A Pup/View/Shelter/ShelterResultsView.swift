//
//  ShelterResultsView.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/26/22.
//

import UIKit

class ShelterResultsView: UIView {
    
    let listView: UITableView = {
        let listView = UITableView()
        listView.sectionHeaderTopPadding = 0
        return listView
    }()
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        setupListView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupListView() {
        listView.separatorStyle = .none
        
        self.addSubview(listView)
        listView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = listView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0)
        let bottomAnchor = listView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        let leadingAnchor = listView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        let trailingAnchor = listView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        
        NSLayoutConstraint.activate([topAnchor, bottomAnchor, leadingAnchor, trailingAnchor])
    }
}
