//
//  DepartmentSegmentedControl.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

enum FilteringMode {
    case android
    case ios
    case design
    case management
    case qa
    case backOffice
    case fronted
    case hr
    case pr
    case backend
    case support
    case analytics
    case all
}

class DepartmentSegmentedControl: UIView {
    
    // MARK:  - Properties
    let selectorIndicator = CALayer()
    
    var textColor: UIColor = UIColor.lightGray
    var selectorTextColor = UIColor.black
    var stackWidth: CGFloat = 0
        
    // MARK:  - Private Properties
    private var buttonTitles: [String]!
    private var buttons = [UIButton]()
    private var selectorView: UIView!
    
    // MARK:  - Initializers
    convenience init(buttonTitles: [String]) {
        self.init(frame: .zero)
        self.buttonTitles = buttonTitles
        
        setupView()
    }
    
    // MARK:  - Private Methods
    
    private func setupView() {
        selectorIndicator.backgroundColor = UIColor(named: "violet")?.cgColor
        layer.addSublayer(selectorIndicator)
        
        createButtons()
        configStackView()
    }
    
    private func configStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        
        for view in stackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: view.frame.width),
                view.heightAnchor.constraint(equalToConstant: view.frame.height)
            ])
        }
        
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
    }
    
    private func createButtons() {
        for buttonTitle in buttonTitles {
            let button = UIButton()
            
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .init(0.2))
            button.sizeToFit()
            button.frame.size.width += 24
            button.frame.size.height = 36
            button.setTitleColor(textColor, for: .normal)
            
            button.addTarget(self, action: #selector(DepartmentSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            
            buttons.append(button)
            stackWidth += button.frame.size.width
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].titleLabel?.font = .systemFont(ofSize: 15, weight: .init(0.30))
        
        selectorIndicator.frame = CGRect(x: buttons[0].frame.minX, y: buttons[0].bounds.height, width: buttons[0].frame.width, height: 2)
    }
    
    // MARK:  - Selectors
    @objc func buttonAction(sender: UIButton) {
        for btn in buttons {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .init(0.30))
                selectorIndicator.frame = CGRect(x: btn.frame.minX, y: btn.bounds.height, width: btn.frame.width, height: 2)
            } else {
                btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .init(0.20))
            }
        }
    }
}

