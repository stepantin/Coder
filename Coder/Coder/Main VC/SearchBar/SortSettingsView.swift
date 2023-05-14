//
//  SortSettingsView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class SortSettingsView: UIView {

    // MARK: - Properties
    var isOn = false
    
    // MARK: - Private Properties
    private let imageView = UIImageView()
    
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
    func setImage() {
        if self.isOn {
            imageView.image = UIImage(named: "menuButton")?.withTintColor(UIColor.setupCustomColor(.violet))
        } else {
            imageView.image = UIImage(named: "menuButton")?.withTintColor(UIColor.setupCustomColor(.lightGray))
        }
    }
    
    func sortingOn() {
        self.isOn = true
        
        setImage()
    }
    
    func sortingOff() {
        self.isOn = false
        
        setImage()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        setImage()
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        layer.cornerRadius = 16
        widthAnchor.constraint(equalToConstant: 44).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
