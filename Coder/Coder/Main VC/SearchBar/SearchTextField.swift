//
//  SearchTextField.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

// MARK:  - Enums
enum SearchFilteringMode {
    case on
    case off
}

enum RightView {
    case sortSettingsView
    case crossButton
}

// MARK: - SearchTextField
class SearchTextField: UITextField {
    
    // MARK: - Properties
    let crossButton = CrossButtonView()
    let lensView = LensView()
    let sortSettingsView = SortSettingsView()
    
    // MARK:  - Private Properties
    private let textPadding = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
    
    // MARK: - Initializer
    init(placeholder: String) {
        super.init(frame: .zero)
        
        setupTextField(placeholder: placeholder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setup(rightView: RightView) {
        switch rightView {
        case .crossButton: self.rightView = crossButton
        case .sortSettingsView: self.rightView = sortSettingsView
        }
    }
    
    // MARK: - Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textPadding)
    }
    
    // MARK: - Private Methods
    private func setupTextField(placeholder: String) {
        backgroundColor = UIColor.setupCustomColor(.extraLightGray)
        layer.cornerRadius = 16
        autocorrectionType = .no
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.setupCustomColor(.lightGray)])
        font = UIFont(name: "Inter-Medium", size: 15)
        
        leftView = lensView
        leftViewMode = .always
        leftView?.alpha = 0.3
        
        rightView = sortSettingsView
        rightViewMode = .always
    }
}
