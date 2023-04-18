//
//  EmployeesTableView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class EmployeesTableView: UITableView {
    
    // MARK: - Properties
    let loadingView = UIView()
    let tableViewRefreshControl = UIRefreshControl()
    let notFoundView = NotFoundView()
    let refreshControlView = RefreshControlView()
    
    // MARK: - Private Properties
    private let listLoadingStackView = UIStackView()
    private let animation = Animation()
    private let networkManager = NetworkManager()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero, style: .grouped)
        
        setupTableView()
        animation.listLoadingAnimation(view: listLoadingStackView)

    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setupCellForRowAt(indexPath: IndexPath, for tableView: EmployeesTableView, with sections: [SectionModel], at viewController: MainViewController) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeesTableViewCell

        if viewController.sortingMode == .birthday {
            let section = sections[indexPath.section]
            let employees = section.sectionEmployees
            cell.birthdayLabel.isHidden = false
            networkManager.downloadImage(url: employees[indexPath.row].avatarUrl) { image in
                let c = tableView.cellForRow(at: indexPath) as? EmployeesTableViewCell
                c?.avatarImageView.image = image
            }
            cell.configureEmployeesCell(cell: cell, for: indexPath, with: employees)
        } else {
            cell.birthdayLabel.isHidden = true
            networkManager.downloadImage(url: viewController.filteredEmployeesList[indexPath.row].avatarUrl) { image in
                let c = tableView.cellForRow(at: indexPath) as? EmployeesTableViewCell
                c?.avatarImageView.image = image
            }
            cell.configureEmployeesCell(cell: cell, for: indexPath, with: viewController.filteredEmployeesList)
        }
                
        return cell
    }
    
    func setViewForHeaderInSection(withView view: HeaderSectionView, from sections: [SectionModel], section: Int, for tableView: EmployeesTableView) -> UIView? {
        guard !sections.isEmpty else { return nil }
                
        if !sections[section].sectionEmployees.isEmpty {
            if section > 0 {
                view.yearLabel.text = sections[section].yearSection
                return view
            } else {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.heightAnchor.constraint(equalToConstant: 0).isActive = true
                return view
            }
        }
        
        return nil
    }
    
    func didSelectRowAt(indexPath: IndexPath, employeeList: [Employee], vc: MainViewController) {
        let index = indexPath.row
        let employee = employeeList[index]
        let profileViewController = ProfileViewController()
        let birthday = CoderDateFormatter(dateString: employee.birthday, inputDateFormat: "yyyy-MM-dd", outputDayFormat: .d, outputMonthFormat: .MMMM, outputYearFormat: .yyyy)
        let birthdayForAge = CoderDateFormatter(dateString: employee.birthday, inputDateFormat: "yyyy-MM-dd", outputDayFormat: .d, outputMonthFormat: .MM, outputYearFormat: .yyyy)
        
        let profileTitleContentView = profileViewController.profileTitleContentView
        let profileDetailsContentView = profileViewController.profileDetailsContentView
        
        networkManager.downloadImage(url: employee.avatarUrl) { image in
            profileTitleContentView.avatarImageView.image = image
        }
        profileTitleContentView.fullNameLabel.text = employee.fullName
        profileTitleContentView.userTagLabel.text = employee.userTag.lowercased()
        profileTitleContentView.updateSubviews()
        
        switch employee.department {
        case "android": profileTitleContentView.departmentLabel.text = "Android"
        case "ios": profileTitleContentView.departmentLabel.text = "iOS"
        case "design": profileTitleContentView.departmentLabel.text = "Дизайн"
        case "management": profileTitleContentView.departmentLabel.text = "Менеджмент"
        case "qa": profileTitleContentView.departmentLabel.text = "QA"
        case "back_office": profileTitleContentView.departmentLabel.text = "Бэк-офис"
        case "frontend": profileTitleContentView.departmentLabel.text = "Frontend"
        case "hr": profileTitleContentView.departmentLabel.text = "HR"
        case "pr": profileTitleContentView.departmentLabel.text = "PR"
        case "backend": profileTitleContentView.departmentLabel.text = "Backend"
        case "support": profileTitleContentView.departmentLabel.text = "Техподдержка"
        case "analytics": profileTitleContentView.departmentLabel.text = "Аналитика"
        default: break
        }
        profileDetailsContentView.birthdayLabel.text = birthday.configureWith(dateElement: [birthday.day!, birthday.month!, birthday.year!])
        profileDetailsContentView.ageLabel.text = birthdayForAge.calculateAge()
        profileDetailsContentView.phoneButton.setTitle(employee.phone, for: .normal)
        profileDetailsContentView.updateSubviews()
        
        vc.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        backgroundColor = .clear
        register(EmployeesTableViewCell.self, forCellReuseIdentifier: "employeeCell")
        rowHeight = 86
        separatorStyle = .none
        sectionFooterHeight = 0
        
        refreshControl = tableViewRefreshControl
        tableViewRefreshControl.tintColor = .clear
        tableViewRefreshControl.addSubview(refreshControlView)
        
        refreshControlView.translatesAutoresizingMaskIntoConstraints = false
        refreshControlView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        refreshControlView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        refreshControlView.centerXAnchor.constraint(equalTo: tableViewRefreshControl.centerXAnchor).isActive = true
        refreshControlView.topAnchor.constraint(equalTo: tableViewRefreshControl.centerYAnchor).isActive = true
        
        configStackView()

        addSubview(notFoundView)
        addSubview(loadingView)
        
        notFoundView.translatesAutoresizingMaskIntoConstraints = false
        notFoundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        notFoundView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        notFoundView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        notFoundView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loadingView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: listLoadingStackView.bottomAnchor).isActive = true
        loadingView.backgroundColor = .white

    }
    
    private func configStackView() {
        loadingView.addSubview(listLoadingStackView)
       
        listLoadingStackView.axis = .vertical
        listLoadingStackView.spacing = 86
        
        for _ in 1...20 {
            let listLoadingView = LoadingView()
            listLoadingStackView.addArrangedSubview(listLoadingView)
        }
        
        listLoadingStackView.layer.position.y = 12
        listLoadingStackView.frame.size.height = 1634
    }
    
}
