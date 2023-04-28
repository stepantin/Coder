//
//  SortingMethodView.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

class SortingMethodView: UIView {
    
    // MARK: - Properties
    var dotIndicator = DotIndicator()
    var isOn = false // state
    
    // MARK: - Private Properties
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
    
    // MARK: - Private Methods
    func updateIndicatorState() {
        dotIndicator.layer.borderWidth = isOn ? 6 : 2
    }

    // MARK: - Methods
    private func setupView(withTitle title: String) {
        addSubview(titleSortingMethod)
        addSubview(dotIndicator)
        
        titleSortingMethod.frame = CGRect(x: 34, y: 0, width: 150, height: 20)
        titleSortingMethod.text = title
        titleSortingMethod.font = UIFont(name: "Inter-Medium", size: 16)
        titleSortingMethod.textColor = UIColor.setupCustomColor(.black)
        dotIndicator.layer.borderWidth = isOn ? 6 : 2
    }
}
