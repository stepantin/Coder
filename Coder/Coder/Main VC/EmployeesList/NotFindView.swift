//
//  NotFindView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class NotFindView: UIView {
    
    // MARK: - Private Properties
    private let imageView = UIImageView()
    private let notFindLabel = UILabel()
    private let correctTheRequestLabel = UILabel()

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
        isHidden = true
                
        addSubview(imageView)
        addSubview(notFindLabel)
        addSubview(correctTheRequestLabel)
        
        imageView.image = UIImage(named: "lensNotFind")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
       
        notFindLabel.text = "Мы никого не нашли"
        notFindLabel.font = .systemFont(ofSize: 17, weight: .init(0.25))
        notFindLabel.textColor = .black
        notFindLabel.sizeToFit()
        notFindLabel.translatesAutoresizingMaskIntoConstraints = false
        notFindLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        notFindLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        notFindLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        correctTheRequestLabel.text = "Попробуй скорректировать запрос"
        correctTheRequestLabel.font = .systemFont(ofSize: 16, weight: .init(0.15))
        correctTheRequestLabel.textColor = .lightGray
        correctTheRequestLabel.sizeToFit()
        correctTheRequestLabel.translatesAutoresizingMaskIntoConstraints = false
        correctTheRequestLabel.topAnchor.constraint(equalTo: notFindLabel.bottomAnchor, constant: 12).isActive = true
        correctTheRequestLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        correctTheRequestLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

