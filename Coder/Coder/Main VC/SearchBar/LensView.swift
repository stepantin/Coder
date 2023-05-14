//
//  LensView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class LensView: UIView {

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

    // MARK: - Private Methods
    private func setupView() {
        let image = UIImage(named: "lens")?.withTintColor(UIColor.setupCustomColor(.black))
        
        addSubview(imageView)

        imageView.image = image
    
        widthAnchor.constraint(equalToConstant: 44).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20.1).isActive = true        
    }
}
