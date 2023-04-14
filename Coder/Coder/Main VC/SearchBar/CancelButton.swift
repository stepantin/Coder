//
//  CancelButton.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class CancelButton: UIButton {
    
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
    
        setTitle("Отмена", for: .normal)
        
        setTitleColor(UIColor(named: "violet"), for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
        
        titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)

        alpha = 0
    }
}
