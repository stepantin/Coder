//
//  DotIndicator.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

class DotIndicator: UIView {
    
    // MARK: - Initializer
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
        frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        layer.cornerRadius = 10
        layer.borderColor = UIColor.setupCustomColor(.violet).cgColor
    }
}
