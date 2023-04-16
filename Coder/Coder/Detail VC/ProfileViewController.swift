//
//  ProfileViewController.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    let profileTitleContentView = ProfileTitleContentView()
    let profileDetailsContentView = ProfileDetailsContentView()
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayouts()
        addTargets()
    }
}

// MARK: - Self Settings
extension ProfileViewController {
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(profileTitleContentView)
        view.addSubview(profileDetailsContentView)
    }
}

// MARK: - Setup Layouts
extension ProfileViewController {
    private func setupLayouts() {
        profileTitleContentView.translatesAutoresizingMaskIntoConstraints = false
        profileTitleContentView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileTitleContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileTitleContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        profileDetailsContentView.translatesAutoresizingMaskIntoConstraints = false
        profileDetailsContentView.topAnchor.constraint(equalTo: profileTitleContentView.bottomAnchor).isActive = true
        profileDetailsContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileDetailsContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        profileDetailsContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: - Add Targets
extension ProfileViewController {
    private func addTargets() {
        profileDetailsContentView.phoneButton.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
        profileTitleContentView.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
}

// MARK: - Selectors
extension ProfileViewController {
    @objc private func callNumber() {
        let phoneNumber = profileDetailsContentView.phoneButton.titleLabel?.text
        guard var phoneNumber = phoneNumber else { return }
        
        let array = phoneNumber.components(separatedBy: "-")
        phoneNumber = array.joined()
        
        if let url = URL(string: "tel://\(phoneNumber)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { success in
                    print(success)
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print(success)
            }
        }
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}

