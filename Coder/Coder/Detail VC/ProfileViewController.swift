//
//  ProfileViewController.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK: - Self Settings
extension ProfileViewController {
    private func setupView() {
        view.backgroundColor = .white
    }
}


