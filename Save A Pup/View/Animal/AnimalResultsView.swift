//
//  AnimalResultsView.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/26/22.
//

import UIKit

class AnimalResultsView: UIView {
    
    let listView: UITableView = {
        let listView = UITableView()
        listView.sectionHeaderTopPadding = 0
        listView.separatorStyle = .none
        listView.translatesAutoresizingMaskIntoConstraints = false
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
        self.addSubview(listView)
        
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            listView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            listView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            listView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
}

