//
//  CrossButtonView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class CrossButtonView: UIView {

    // MARK: - Properties
    let button = UIButton()
    private let image = UIImage(named: "cross")

    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupButton() {
        addSubview(button)
        
        button.setImage(image?.withTintColor(.lightGray), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 14.22).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 14.22).isActive = true
        button.widthAnchor.constraint(equalToConstant: 15.56).isActive = true
        button.heightAnchor.constraint(equalToConstant: 15.56).isActive = true
        
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
