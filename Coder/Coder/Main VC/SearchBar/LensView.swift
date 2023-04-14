//
//  LensView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class LensView: UIView {

    // MARK: - Private Properties
    private let frameView = CGRect(x: 0, y: 0, width: 44, height: 40)
    private let frameImageView = CGRect(x: 14, y: 10, width: 20.01, height: 20)
    private let imageView = UIImageView()
    
    //MARK: - Initializers
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
        let image = UIImage(named: "lens")?.withTintColor(.black)
        
        imageView.image = image
        imageView.frame = frameImageView
        
        addSubview(imageView)
        
        frame = frameView
    }
}
