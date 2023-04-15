//
//  DepartmentSegmentedControl.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

// MARK: - Protocols
protocol DepartmentSegmentedControlDelegate: AnyObject {
    func set(filteringMode: FilteringMode)
}

// MARK: - Enums
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

// MARK: - DepartmentSegmentedControl
class DepartmentSegmentedControl: UIView {
    
    // MARK: - Delegate Property
    weak var delegate: DepartmentSegmentedControlDelegate?
    
    // MARK: - Properties
    let selectorIndicator = CALayer()
    var textColor: UIColor = UIColor.lightGray
    var selectorTextColor = UIColor.black
    var stackWidth: CGFloat = 0
        
    // MARK: - Private Properties
    private var buttonTitles: [String]!
    private var buttons = [UIButton]()
    private var selectorView: UIView!
    
    // MARK: - Initializers
    convenience init(buttonTitles: [String]) {
        self.init(frame: .zero)
        self.buttonTitles = buttonTitles
        
        setupView()
    }
    
    // MARK: - Methods
    func filterEmployeeList(_ employeeList: [Employee], withDepartmentFilteringMode mode: FilteringMode, withTextFrom textField: SearchTextField) -> [Employee] {
        var filteredEmployeesList = employeeList

        if let inputText = textField.text?.uppercased() {
            
            func filteredByDepartment(_ department: String) {
                filteredEmployeesList = filteredEmployeesList.filter { $0.department == department }
            }
            
            func filteredByInputText(withDepartment department: String) {
                filteredByDepartment(department)
                filteredEmployeesList = filteredEmployeesList.filter {$0.firstName.uppercased().hasPrefix(inputText) ||
                    $0.lastName.uppercased().hasPrefix(inputText) ||
                    $0.userTag.uppercased().hasPrefix(inputText)}
            }
            
            if inputText == "" {
                switch mode {
                case .all: return employeeList
                case .android: filteredByDepartment("android")
                case .ios: filteredByDepartment("ios")
                case .design: filteredByDepartment("design")
                case .management: filteredByDepartment("management")
                case .qa: filteredByDepartment("qa")
                case .backOffice: filteredByDepartment("back_office")
                case .fronted: filteredByDepartment("frontend")
                case .hr: filteredByDepartment("hr")
                case .pr: filteredByDepartment("pr")
                case .backend: filteredByDepartment("backend")
                case .support: filteredByDepartment("support")
                case .analytics: filteredByDepartment("analytics")
                }
            } else {
                switch mode {
                case .all: return employeeList.filter {$0.firstName.uppercased().hasPrefix(inputText) || $0.lastName.uppercased().hasPrefix(inputText) || $0.userTag.uppercased().hasPrefix(inputText)}
                case .android: filteredByInputText(withDepartment: "android")
                case .ios: filteredByInputText(withDepartment: "ios")
                case .design: filteredByInputText(withDepartment: "design")
                case .management: filteredByInputText(withDepartment: "management")
                case .qa: filteredByInputText(withDepartment: "qa")
                case .backOffice: filteredByInputText(withDepartment: "back_office")
                case .fronted: filteredByInputText(withDepartment: "frontend")
                case .hr: filteredByInputText(withDepartment: "hr")
                case .pr: filteredByInputText(withDepartment: "pr")
                case .backend: filteredByInputText(withDepartment: "backend")
                case .support: filteredByInputText(withDepartment: "support")
                case .analytics: filteredByInputText(withDepartment: "analytics")
                }
            }
        }
        return filteredEmployeesList
    }
    
    // MARK: - Private Methods
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
    
    // MARK: - Selectors
    @objc func buttonAction(sender: UIButton) {
        for btn in buttons {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .init(0.30))
                selectorIndicator.frame = CGRect(x: btn.frame.minX, y: btn.bounds.height, width: btn.frame.width, height: 2)
                
                switch btn.titleLabel?.text {
                case "Все": self.delegate?.set(filteringMode: .all)
                case "Дизайн": self.delegate?.set(filteringMode: .design)
                case "Аналитика": self.delegate?.set(filteringMode: .analytics)
                case "Менеджмент": self.delegate?.set(filteringMode: .management)
                case "iOS": self.delegate?.set(filteringMode: .ios)
                case "Android": self.delegate?.set(filteringMode: .android)
                case "QA": self.delegate?.set(filteringMode: .qa)
                case "Backend": self.delegate?.set(filteringMode: .backend)
                case "Frontend": self.delegate?.set(filteringMode: .fronted)
                case "HR": self.delegate?.set(filteringMode: .hr)
                case "PR": self.delegate?.set(filteringMode: .pr)
                case "Бэк-офис": self.delegate?.set(filteringMode: .backOffice)
                case "Техподдержка": self.delegate?.set(filteringMode: .support)
                default: break
                }
            } else {
                btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .init(0.20))
            }
        }
    }
}

