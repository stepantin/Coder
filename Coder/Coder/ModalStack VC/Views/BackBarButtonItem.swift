//
//  BackBarButtonItem.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

class BackBarButtonItem: UIBarButtonItem {
    
    // MARK: - Initializer
    override init() {
        super.init()
        
        setupBarButtonItem()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupBarButtonItem() {
        image = UIImage(named: "back")?.withTintColor(UIColor.setupCustomColor(.black), renderingMode: .alwaysOriginal)
        imageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
}
