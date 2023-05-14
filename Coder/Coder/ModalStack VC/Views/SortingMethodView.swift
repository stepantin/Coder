//
//  SortingMethodView.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

class SortingMethodView: UIView {
    
    // MARK: - Properties
    var isOn = false {
        didSet {
            dotIndicator.layer.borderWidth = isOn ? 6 : 2
        }
    }
    
    // MARK: - Private Properties
    private var dotIndicator = UIView()
    private let titleSortingMethod = UILabel()
    private let defaults = UserDefaults.standard
    
    // MARK:  - Initializer
    init(withTitle title: String) {
        super.init(frame: .zero)
        
        setupView(withTitle: title)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func setupView(withTitle title: String) {
        addSubview(titleSortingMethod)
        addSubview(dotIndicator)
        
        dotIndicator.layer.cornerRadius = 10
        dotIndicator.layer.borderColor = UIColor.setupCustomColor(.violet).cgColor
        
        titleSortingMethod.text = title
        titleSortingMethod.font = UIFont(name: "Inter-Medium", size: 16)
        titleSortingMethod.textColor = UIColor.setupCustomColor(.black)
        
        dotIndicator.translatesAutoresizingMaskIntoConstraints = false
        dotIndicator.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dotIndicator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dotIndicator.widthAnchor.constraint(equalToConstant: 20).isActive = true
        dotIndicator.heightAnchor.constraint(equalToConstant: 20).isActive = true
       
        titleSortingMethod.translatesAutoresizingMaskIntoConstraints = false
        titleSortingMethod.leftAnchor.constraint(equalTo: dotIndicator.rightAnchor, constant: 14).isActive = true
        titleSortingMethod.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleSortingMethod.widthAnchor.constraint(equalToConstant: 150).isActive = true
        titleSortingMethod.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
