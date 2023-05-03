//
//  ProfileTitleContentView.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

class ProfileTitleContentView: UIView {
    
    // MARK: - Properties
    let avatarImageView = UIImageView()
    let fullNameLabel = UILabel()
    let userTagLabel = UILabel()
    let departmentLabel = UILabel()
    let contentSubview = UIView()
    let backButton = UIButton(type: .custom)
    
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
        fullNameLabel.sizeToFit()
        userTagLabel.sizeToFit()
        departmentLabel.sizeToFit()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = UIColor.setupCustomColor(.extraLightGray)
        
        addSubviews()
        applyViewsCustomization()
        updateSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(avatarImageView)
        contentSubview.addSubview(fullNameLabel)
        contentSubview.addSubview(userTagLabel)
        addSubview(contentSubview)
        addSubview(departmentLabel)
        addSubview(backButton)
    }
    
    private func applyViewsCustomization() {
        avatarImageView.layer.cornerRadius = 51
        avatarImageView.clipsToBounds = true
        
        fullNameLabel.font = UIFont(name: "Inter-Bold", size: 24)
        fullNameLabel.textColor = UIColor.setupCustomColor(.black)
        
        userTagLabel.font = UIFont(name: "Inter-Regular", size: 17)
        userTagLabel.textColor = UIColor.setupCustomColor(.gray)
        
        departmentLabel.font = UIFont(name: "Inter-Regular", size: 13)
        departmentLabel.textColor = UIColor.setupCustomColor(.darkGray)
        
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.setImage(UIImage(named: "back")?.withTintColor(.lightGray), for: .highlighted)
    }
    
    private func setupConstraints() {
        self.bottomAnchor.constraint(equalTo: departmentLabel.bottomAnchor, constant: 24).isActive = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 82).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 104).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 104).isActive = true
        
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.leadingAnchor.constraint(equalTo: contentSubview.leadingAnchor).isActive = true
        fullNameLabel.topAnchor.constraint(equalTo: contentSubview.topAnchor).isActive = true
        
        userTagLabel.translatesAutoresizingMaskIntoConstraints = false
        userTagLabel.leadingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor, constant: 4).isActive = true
        userTagLabel.centerYAnchor.constraint(equalTo: contentSubview.centerYAnchor).isActive = true
        
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        departmentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        departmentLabel.topAnchor.constraint(equalTo: contentSubview.bottomAnchor, constant: 12).isActive = true
        
        contentSubview.translatesAutoresizingMaskIntoConstraints = false
        contentSubview.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 24).isActive = true
        contentSubview.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor).isActive = true
        contentSubview.trailingAnchor.constraint(equalTo: userTagLabel.trailingAnchor).isActive = true
        contentSubview.bottomAnchor.constraint(equalTo: fullNameLabel.bottomAnchor).isActive = true
        contentSubview.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        if #available(iOS 15, *) {
            backButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        } else {
            backButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        }
    }
}
