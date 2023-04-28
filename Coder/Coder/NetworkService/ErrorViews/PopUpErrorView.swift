//
//  PopUpErrorView.swift
//  Coder
//
//  Created by Константин Степанов on 16.04.2023.
//

import UIKit

// MARK: - Enums
enum ErrorDescription: String {
    case internetError = "Не могу обновить данные. \nПроверь соединение с интернетом."
    case apiError = "Не могу обновить данные. \nЧто-то пошло не так."
}

// MARK: - InternetErrorView
class PopUpErrorView: UIView {

    // MARK: - Properties
    var errorLabel = UILabel()
        
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
        backgroundColor = UIColor.setupCustomColor(.red)
        addSubview(errorLabel)
        
        errorLabel.textAlignment = .left
        errorLabel.numberOfLines = 2
        errorLabel.font = UIFont(name: "Inter-Medium", size: 13)
        errorLabel.textColor = .white
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
}
