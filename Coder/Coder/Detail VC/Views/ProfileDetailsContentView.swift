//
//  ProfileDetailsContentView.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

class ProfileDetailsContentView: UIView {
    
    // MARK: - Properties
    let birthdayLabel = UILabel()
    let ageLabel = UILabel()
    let phoneButton = UIButton(type: .system)
    let starImageView = UIImageView(image: UIImage(named: "star"))
    let phoneImageView = UIImageView(image: UIImage(named: "phone"))
    let sectionLine = UIView()
    let birthdayContentSubview = UIView()
    let phoneContentSubview = UIView()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func updateSubviews() {
        birthdayLabel.sizeToFit()
        ageLabel.sizeToFit()
        phoneButton.sizeToFit()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        
        addSubviews()
        applyViewsCustomization()
        updateSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        birthdayContentSubview.addSubview(starImageView)
        birthdayContentSubview.addSubview(birthdayLabel)
        birthdayContentSubview.addSubview(ageLabel)
        
        phoneContentSubview.addSubview(phoneImageView)
        phoneContentSubview.addSubview(phoneButton)
        
        addSubview(birthdayContentSubview)
        addSubview(phoneContentSubview)
        addSubview(sectionLine)
    }
    
    private func applyViewsCustomization() {
        birthdayLabel.font = .systemFont(ofSize: 16, weight: .init(0.20))
        birthdayLabel.textColor = .black
        
        ageLabel.font = .systemFont(ofSize: 16, weight: .init(0.20))
        ageLabel.textColor = .lightGray
        
        phoneButton.setTitleColor(.black, for: .normal)
        phoneButton.setTitleColor(.lightGray, for: .highlighted)
        phoneButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .init(0.20))
        
        sectionLine.backgroundColor = UIColor(named: "coderLightGray")

    }
    
    private func setupConstraints() {
        birthdayContentSubview.translatesAutoresizingMaskIntoConstraints = false
        birthdayContentSubview.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        birthdayContentSubview.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        birthdayContentSubview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        birthdayContentSubview.heightAnchor.constraint(equalToConstant: 74).isActive = true
        
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageView.leadingAnchor.constraint(equalTo: birthdayContentSubview.leadingAnchor, constant: 18.01).isActive = true
        starImageView.centerYAnchor.constraint(equalTo: birthdayContentSubview.centerYAnchor).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 20.03).isActive = true
        starImageView.heightAnchor.constraint(equalToConstant: 19.13).isActive = true
        
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        birthdayLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 13.97).isActive = true
        birthdayLabel.centerYAnchor.constraint(equalTo: birthdayContentSubview.centerYAnchor).isActive = true
        
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.trailingAnchor.constraint(equalTo: birthdayContentSubview.trailingAnchor, constant: -20).isActive = true
        ageLabel.centerYAnchor.constraint(equalTo: birthdayContentSubview.centerYAnchor).isActive = true
        
        phoneContentSubview.translatesAutoresizingMaskIntoConstraints = false
        phoneContentSubview.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        phoneContentSubview.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        phoneContentSubview.topAnchor.constraint(equalTo: birthdayContentSubview.bottomAnchor).isActive = true
        phoneContentSubview.heightAnchor.constraint(equalToConstant: 74).isActive = true
        
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        phoneImageView.leadingAnchor.constraint(equalTo: phoneContentSubview.leadingAnchor, constant: 17.98).isActive = true
        phoneImageView.centerYAnchor.constraint(equalTo: phoneContentSubview.centerYAnchor).isActive = true
        phoneImageView.widthAnchor.constraint(equalToConstant: 19.93).isActive = true
        phoneImageView.heightAnchor.constraint(equalToConstant: 19.87).isActive = true
        
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        phoneButton.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor, constant: 14.09).isActive = true
        phoneButton.centerYAnchor.constraint(equalTo: phoneContentSubview.centerYAnchor).isActive = true
        
        sectionLine.translatesAutoresizingMaskIntoConstraints = false
        sectionLine.centerYAnchor.constraint(equalTo: birthdayContentSubview.bottomAnchor).isActive = true
        sectionLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        sectionLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        sectionLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
}

