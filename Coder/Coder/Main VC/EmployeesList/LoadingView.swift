//
//  LoadingView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class LoadingView: UIView {

    // MARK: - Private Properties
    private let avatarView = UIView()
    private let nameView = UIView()
    private let departmentView = UIView()
    
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
        addSubviews()
        setupLayouts()
        applyCustomizationsView()
    }
    
    private func setupLayouts() {
        avatarView.frame = CGRect(x: 16, y: 12, width: 72, height: 72)
        nameView.frame = CGRect(x: 104, y: 31, width: 144, height: 16)
        departmentView.frame = CGRect(x: 104, y: nameView.frame.maxY + 6, width: 80, height: 12)
    }
    
    private func addSubviews() {
        addSubview(avatarView)
        addSubview(nameView)
        addSubview(departmentView)
    }
    
    private func applyCustomizationsView() {
        avatarView.layer.cornerRadius = 36
        avatarView.clipsToBounds = true
        avatarView.layer.addSublayer(gradientLayer(to: avatarView))
        
        nameView.layer.cornerRadius = 8
        nameView.clipsToBounds = true
        nameView.layer.addSublayer(gradientLayer(to: nameView))

        departmentView.layer.cornerRadius = 6
        departmentView.clipsToBounds = true
        departmentView.layer.addSublayer(gradientLayer(to: departmentView))
    }
    
    private func gradientLayer(to view: UIView) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        let startPoint = CGPoint(x: 0, y: 0.5)
        let endPoint = CGPoint(x: 1, y: 0.5)
        let firstGradientColor = UIColor(red: 243/255, green: 243/255, blue: 246/255, alpha: 1)
        let lastGradientColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        gradient.colors = [firstGradientColor.cgColor, lastGradientColor.cgColor]
        gradient.type = .axial
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = view.bounds
        return gradient
    }
}

