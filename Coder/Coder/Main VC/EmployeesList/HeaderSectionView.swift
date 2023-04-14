//
//  HeaderSectionView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class HeaderSectionView: UIView {
    
    // MARK: - Properties
    let viewColor = UIColor(red: 195/255, green: 195/255, blue: 198/255, alpha: 1)
    
    // MARK: - Lazy Properties
    lazy var yearLabel = UILabel()
    lazy var leftLine = UIView()
    lazy var rightLine = UIView()
    
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
        heightAnchor.constraint(equalToConstant: 68).isActive = true

        backgroundColor = .clear
        layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        addSubview(leftLine)
        addSubview(yearLabel)
        addSubview(rightLine)
        
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        leftLine.widthAnchor.constraint(equalToConstant: 72).isActive = true
        leftLine.heightAnchor.constraint(lessThanOrEqualToConstant: 1).isActive = true
        leftLine.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        leftLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        leftLine.backgroundColor = viewColor
        leftLine.layer.cornerRadius = 0.5
        
        rightLine.translatesAutoresizingMaskIntoConstraints = false
        rightLine.widthAnchor.constraint(equalToConstant: 72).isActive = true
        rightLine.heightAnchor.constraint(lessThanOrEqualToConstant: 1).isActive = true
        rightLine.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rightLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
        rightLine.backgroundColor = viewColor
        rightLine.layer.cornerRadius = 0.5
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        yearLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 20).isActive = true
        yearLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        yearLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        yearLabel.textColor = viewColor
        yearLabel.font = .systemFont(ofSize: 15, weight: .init(0.2))
        yearLabel.textAlignment = .center
    }
}

