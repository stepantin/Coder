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
    case frontend
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
    var textColor: UIColor = UIColor.setupCustomColor(.gray)
    var selectorTextColor = UIColor.setupCustomColor(.black)
    var stackWidth: CGFloat = 0
        
    // MARK: - Private Properties
    private var buttonTitles: [Departments]!
    private var buttons = [UIButton]()
    private var selectorView: UIView!
    
    // MARK: - Initializers
    convenience init(buttonTitles: [Departments]) {
        self.init(frame: .zero)
        self.buttonTitles = buttonTitles
        
        setupView()
    }
    
    // MARK: - Methods
    func filterEmployeeList(_ employeeList: [Employee], withDepartmentFilteringMode mode: FilteringMode, withTextFrom textField: SearchTextField) -> [Employee] {
        var filteredEmployeesList = employeeList

        if let inputText = textField.text?.uppercased() {
            
            func filteredByDepartment(_ department: Departments) {
                filteredEmployeesList = filteredEmployeesList.filter { $0.department == .describing(department.self) }
            }
            
            func filteredByInputText(withDepartment department: Departments) {
                filteredByDepartment(department)
                filteredEmployeesList = filteredEmployeesList.filter {
                    $0.firstName.uppercased().hasPrefix(inputText) ||
                    $0.lastName.uppercased().hasPrefix(inputText) ||
                    $0.userTag.uppercased().hasPrefix(inputText)}
            }
            
            if inputText == "" {
                switch mode {
                case .all: return employeeList
                case .android: filteredByDepartment(.android)
                case .ios: filteredByDepartment(.ios)
                case .design: filteredByDepartment(.design)
                case .management: filteredByDepartment(.management)
                case .qa: filteredByDepartment(.qa)
                case .backOffice: filteredByDepartment(.backOffice)
                case .frontend: filteredByDepartment(.frontend)
                case .hr: filteredByDepartment(.hr)
                case .pr: filteredByDepartment(.pr)
                case .backend: filteredByDepartment(.backend)
                case .support: filteredByDepartment(.support)
                case .analytics: filteredByDepartment(.analytics)
                }
            } else {
                switch mode {
                case .all: return employeeList.filter {$0.firstName.uppercased().hasPrefix(inputText) || $0.lastName.uppercased().hasPrefix(inputText) || $0.userTag.uppercased().hasPrefix(inputText)}
                case .android: filteredByInputText(withDepartment: .android)
                case .ios: filteredByInputText(withDepartment: .ios)
                case .design: filteredByInputText(withDepartment: .design)
                case .management: filteredByInputText(withDepartment: .management)
                case .qa: filteredByInputText(withDepartment: .qa)
                case .backOffice: filteredByInputText(withDepartment: .backOffice)
                case .frontend: filteredByInputText(withDepartment: .frontend)
                case .hr: filteredByInputText(withDepartment: .hr)
                case .pr: filteredByInputText(withDepartment: .pr)
                case .backend: filteredByInputText(withDepartment: .backend)
                case .support: filteredByInputText(withDepartment: .support)
                case .analytics: filteredByInputText(withDepartment: .analytics)
                }
            }
        }
        return filteredEmployeesList
    }
    
    // MARK: - Private Methods
    private func setupView() {
        selectorIndicator.backgroundColor = UIColor.setupCustomColor(.violet).cgColor
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
            
            button.setTitle(buttonTitle.rawValue, for: .normal)
            button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 15)
            button.sizeToFit()
            button.frame.size.width += 24
            button.frame.size.height = 36
            button.setTitleColor(textColor, for: .normal)
            
            button.addTarget(self, action: #selector(DepartmentSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            
            buttons.append(button)
            stackWidth += button.frame.size.width
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        buttons[0].titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 15)
        
        selectorIndicator.frame = CGRect(x: buttons[0].frame.minX, y: buttons[0].bounds.height, width: buttons[0].frame.width, height: 2)
    }
    
    // MARK: - Selectors
    @objc func buttonAction(sender: UIButton) {
        for btn in buttons {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                btn.setTitleColor(selectorTextColor, for: .normal)
                btn.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 15)
                selectorIndicator.frame = CGRect(x: btn.frame.minX, y: btn.bounds.height, width: btn.frame.width, height: 2)
                
                switch btn.titleLabel?.text {
                case Departments.all.rawValue : self.delegate?.set(filteringMode: .all)
                case Departments.design.rawValue: self.delegate?.set(filteringMode: .design)
                case Departments.analytics.rawValue: self.delegate?.set(filteringMode: .analytics)
                case Departments.management.rawValue: self.delegate?.set(filteringMode: .management)
                case Departments.ios.rawValue: self.delegate?.set(filteringMode: .ios)
                case Departments.android.rawValue: self.delegate?.set(filteringMode: .android)
                case Departments.qa.rawValue: self.delegate?.set(filteringMode: .qa)
                case Departments.backend.rawValue: self.delegate?.set(filteringMode: .backend)
                case Departments.frontend.rawValue: self.delegate?.set(filteringMode: .frontend)
                case Departments.hr.rawValue: self.delegate?.set(filteringMode: .hr)
                case Departments.pr.rawValue: self.delegate?.set(filteringMode: .pr)
                case Departments.backOffice.rawValue: self.delegate?.set(filteringMode: .backOffice)
                case Departments.support.rawValue: self.delegate?.set(filteringMode: .support)
                default: break
                }
            } else {
                btn.titleLabel?.font = UIFont(name: "Inter-Medium", size: 15)
            }
        }
    }
}

