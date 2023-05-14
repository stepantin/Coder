//
//  MainViewController.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

// MARK: - Enums
enum SortingMode {
    case alphabet
    case birthday
}

// MARK: - MainViewController
class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    private var sortingMode: SortingMode = .alphabet
    private var departmentFilteringMode: FilteringMode = .all
    private var defaultEmployeeList = [Employee]()
    private var filteredEmployeesList = [Employee]()
    private var defaultTableViewSections = [SectionModel]()
    private var filteredTableViewSections = [SectionModel]()
    private var cancelButton = CancelButton()
    private var departmentSegmentedControl = DepartmentSegmentedControl()
    private var employeesTableView = EmployeesTableView()
    private var headerSectionView = HeaderSectionView()
    private var errorView = ErrorView()
    private var backButton = BackBarButtonItem()
    private var popUpErrorView = PopUpErrorView()
    private let placeholder = "Введи имя, тег, почту..."
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let dividingLine = UIView()
    private let networkManager = NetworkManager()
    private let curentDate = CoderDateFormatter()
    private let defaults = UserDefaults.standard
    private var timer: Timer? = Timer()
    private var time = 0
    
    //MARK: - Lazy Private Properties
    private lazy var searchTextField = SearchTextField(placeholder: placeholder)
    private lazy var currentYear = Int(curentDate.year!)!
    
    // MARK: - Constraints
    private lazy var searchTextFieldLeftAnchor = searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
    private lazy var searchTextFieldTopAnchor = searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
    private lazy var searchTextFieldWidthAnchor = searchTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32)
    private lazy var searchTextFieldDecreaseWidthAnchor = searchTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -110)
    private lazy var searchTextFieldHeightAnchor = searchTextField.heightAnchor.constraint(equalToConstant: 40)
    
    private lazy var cancelButtonLeftAnchor = cancelButton.leftAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: 12)
    private lazy var cancelButtonTopAnchor = cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 71)
    private lazy var cancelButtonWidthAnchor = cancelButton.widthAnchor.constraint(equalToConstant: 54)
    private lazy var cancelButtonHeightAnchor = cancelButton.heightAnchor.constraint(equalToConstant: 18)
    
    private lazy var scrollViewBottomAnchor = scrollView.bottomAnchor.constraint(equalTo: dividingLine.topAnchor)
    private lazy var scrollViewLeftAnchor = scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
    private lazy var scrollViewRightAnchor = scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
    private lazy var scrollViewHeightAnchor = scrollView.heightAnchor.constraint(equalToConstant: 36)
    
    private lazy var contentViewLeftAnchor = contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16)
    private lazy var contentViewRightAnchor = contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16)
    private lazy var contentViewWidthAnchor = contentView.widthAnchor.constraint(equalTo: departmentSegmentedControl.widthAnchor)
    private lazy var contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
    
    private lazy var dividingLineTopAnchor = dividingLine.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
    private lazy var dividingLineHeightAnchor = dividingLine.heightAnchor.constraint(equalToConstant: 0.33)
    private lazy var dividingLineWidthAnchor = dividingLine.widthAnchor.constraint(equalTo: view.widthAnchor)
    
    private lazy var employeesTableViewTopAnchor = employeesTableView.topAnchor.constraint(equalTo: dividingLine.bottomAnchor)
    private lazy var employeesTableViewBottomAnchor = employeesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    private lazy var employeesTableViewLeftAnchor = employeesTableView.leftAnchor.constraint(equalTo: view.leftAnchor)
    private lazy var employeesTableViewWidthAnchor = employeesTableView.widthAnchor.constraint(equalTo: view.widthAnchor)
    
    private lazy var errorViewLeftAnchor = errorView.leftAnchor.constraint(equalTo: view.leftAnchor)
    private lazy var errorViewTopAnchor = errorView.topAnchor.constraint(equalTo: view.topAnchor)
    private lazy var errorViewWidthAnchor = errorView.widthAnchor.constraint(equalTo: view.widthAnchor)
    private lazy var errorViewHeightAnchor = errorView.heightAnchor.constraint(equalTo: view.heightAnchor)

    private lazy var popUpErrorViewLeftAnchor = popUpErrorView.leftAnchor.constraint(equalTo: view.leftAnchor)
    private lazy var popUpErrorViewTopAnchorWhenAppear = popUpErrorView.topAnchor.constraint(equalTo: view.topAnchor)
    private lazy var popUpErrorViewTopAnchorWhenDisappear = popUpErrorView.topAnchor.constraint(equalTo: view.topAnchor, constant: -110)
    private lazy var popUpErrorViewWidthAnchor = popUpErrorView.widthAnchor.constraint(equalTo: view.widthAnchor)
    private lazy var popUpErrorViewHeightAnchor = popUpErrorView.heightAnchor.constraint(equalToConstant: 110)
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataForATableViewCell()
        resetSortSettings()
        setupView()
        addSubviews()
        setupLayouts()
        addGestures()
        applyViewsCustomization()
        addNotifications()
    }
}

// MARK: - Self Settings
extension MainViewController {
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        searchTextField.delegate = self
        employeesTableView.dataSource = self
        employeesTableView.delegate = self
        departmentSegmentedControl.delegate = self
    }
    
    private func resetSortSettings() {
        defaults.set(true, forKey: "alphabetSortingMethodViewState")
        defaults.set(false, forKey: "birthdaySortingMethodViewState")
    }
    
    private func addNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: UIApplication.willResignActiveNotification, object: nil)
    }
}

// MARK: - Add Subviews
extension MainViewController {
    private func addSubviews() {
        view.addSubview(searchTextField)
        view.addSubview(cancelButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(departmentSegmentedControl)
        view.addSubview(dividingLine)
        view.addSubview(employeesTableView)
        view.addSubview(errorView)
        view.addSubview(popUpErrorView)
    }
}

// MARK: - Setup Layouts
extension MainViewController {
    private func setupLayouts() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextFieldTopAnchor.isActive = true
        searchTextFieldLeftAnchor.isActive = true
        searchTextFieldWidthAnchor.isActive = true
        searchTextFieldHeightAnchor.isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButtonTopAnchor.isActive = true
        cancelButtonLeftAnchor.isActive = true
        cancelButtonWidthAnchor.isActive = true
        cancelButtonHeightAnchor.isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollViewLeftAnchor.isActive = true
        scrollViewRightAnchor.isActive = true
        scrollViewBottomAnchor.isActive = true
        scrollViewHeightAnchor.isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentViewLeftAnchor.isActive = true
        contentViewRightAnchor.isActive = true
        contentViewWidthAnchor.isActive = true
        contentViewHeightAnchor.isActive = true
        
        dividingLine.translatesAutoresizingMaskIntoConstraints = false
        dividingLineTopAnchor.isActive = true
        dividingLineWidthAnchor.isActive = true
        dividingLineHeightAnchor.isActive = true
        
        employeesTableView.translatesAutoresizingMaskIntoConstraints = false
        employeesTableViewTopAnchor.isActive = true
        employeesTableViewLeftAnchor.isActive = true
        employeesTableViewWidthAnchor.isActive = true
        employeesTableViewBottomAnchor.isActive = true
        
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorViewTopAnchor.isActive = true
        errorViewLeftAnchor.isActive = true
        errorViewWidthAnchor.isActive = true
        errorViewHeightAnchor.isActive = true
        
        popUpErrorView.translatesAutoresizingMaskIntoConstraints = false
        popUpErrorViewLeftAnchor.isActive = true
        popUpErrorViewTopAnchorWhenDisappear.isActive = true
        popUpErrorViewWidthAnchor.isActive = true
        popUpErrorViewHeightAnchor.isActive = true
    }
}

// MARK: - Views Customization
extension MainViewController {
    private func applyViewsCustomization() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        
        dividingLine.backgroundColor = UIColor.setupCustomColor(.lightGray)
        
        addTargets()
    }
    
    private func addTargets() {
        searchTextField.crossButton.button.addTarget(self, action: #selector(clear), for: .allTouchEvents)
        errorView.tryAgainButton.addTarget(self, action: #selector(repeatRequest), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelEditing), for: .touchUpInside)
        employeesTableView.refreshControl?.addTarget(self, action: #selector(reloadEmployeeTableView), for: .valueChanged)
    }
}

// MARK: - Gestures
extension MainViewController {
    private func addGestures() {
        let sortSettingsViewGesture = UITapGestureRecognizer(target: self, action: #selector(presentModalStackVC))
        searchTextField.sortSettingsView.addGestureRecognizer(sortSettingsViewGesture)
        searchTextField.sortSettingsView.isUserInteractionEnabled = true
        
        let popUpErrorViewGesture = UITapGestureRecognizer(target: self, action: #selector(hidePopUpErrorView))
        popUpErrorView.addGestureRecognizer(popUpErrorViewGesture)
        popUpErrorView.isUserInteractionEnabled = true
    }
}

// MARK: - Selectors
extension MainViewController {
    
    @objc private func clear() {
        searchTextField.text = ""
    }
    
    @objc private func cancelEditing() {
        searchTextField.text = ""
        searchTextField.placeholder = placeholder
        searchTextField.endEditing(true)
    }
    
    @objc private func reloadEmployeeTableView() {
        if employeesTableView.refreshControl!.isRefreshing {
            employeesTableView.refreshControlView.startAnimating()
        }
        
        employeesTableView.loadingView.isHidden = false
        employeesTableView.notFoundView.isHidden = true
        headerSectionView.isHidden = true
        fetchDataForATableViewCell()
    }
    
    @objc private func repeatRequest() {
        networkManager.requestValue = .dynamicTrue
        fetchDataForATableViewCell()
        errorView.isHidden = true
        employeesTableView.reloadData()
    }
    
    @objc private func presentModalStackVC() {
        UIView.animate(withDuration: 0.3) {
            self.searchTextField.sortSettingsView.alpha = 0
            self.searchTextField.sortSettingsView.alpha = 1
        }
        
        let nc = UINavigationController()
        let modalStackViewController = ModalStackViewController()
        modalStackViewController.navigationItem.leftBarButtonItem = backButton
        backButton.target = self
        backButton.action = #selector(backToMainVC)
        nc.viewControllers = [modalStackViewController]
        modalStackViewController.delegate = self
        navigationController?.present(nc, animated: true)
    }
    
    @objc private func backToMainVC() {
        dismiss(animated: true)
    }
    
    @objc private func hidePopUpErrorView() {
        popUpErrorViewTopAnchorWhenAppear.isActive = false
        popUpErrorViewTopAnchorWhenDisappear.isActive = true

        UIView.animate(withDuration: 0.2) {
            self.popUpErrorView.superview?.layoutIfNeeded()
            self.view.window?.overrideUserInterfaceStyle = .light
        }
    }
    
    @objc func reloadTableData(_ notification: Notification) {
        employeesTableView.reloadData()
    }
}

// MARK: - Network
extension MainViewController {
    func fetchDataForATableViewCell() {
        restartTimer()
        employeesTableView.loadingView.isHidden = false
        employeesTableView.notFoundView.isHidden = true
        headerSectionView.isHidden = true
        
        networkManager.fetchData(successComplition: { [weak self] employees in
            guard let self = self else { return }
            
            defaultEmployeeList = employees.items
            filteredEmployeesList = defaultEmployeeList
            
            var firstSection = SectionModel(yearSection: "", sectionEmployees: defaultEmployeeList)
            var secondSection = SectionModel(yearSection: "\(currentYear + 1)", sectionEmployees: defaultEmployeeList)
            firstSection.sectionEmployees = firstSection.getCurrentBirthdayYear()
            secondSection.sectionEmployees = secondSection.getNextBirthdayYearList()
            
            defaultTableViewSections.removeAll()
            defaultTableViewSections.append(firstSection)
            defaultTableViewSections.append(secondSection)
            
            filteredTableViewSections = defaultTableViewSections
                                    
            DispatchQueue.main.async {
                self.filterEmployeeList()
                self.checkEmployeesList()
                self.employeesTableView.reloadData()
                self.headerSectionView.isHidden = false
            }
        }) { [weak self] errorDescription in
            guard let self = self else { return }

            switch errorDescription {
            case .apiError: errorComplition(.apiError)
            case .internetError: errorComplition(.internetError)
            }
        }
    }
    
    private func errorComplition(_ errorDescription: ErrorDescription) {
        DispatchQueue.main.async {
            self.errorView.isHidden = false
            self.popUpErrorView.errorLabel.text = errorDescription.rawValue
            self.popUpErrorView.errorLabel.sizeToFit()
            self.employeesTableView.loadingView.isHidden = true
            self.headerSectionView.isHidden = false
            self.popUpErrorViewAppear()
        }
    }
    
    private func popUpErrorViewAppear() {
        popUpErrorViewTopAnchorWhenDisappear.isActive = false
        popUpErrorViewTopAnchorWhenAppear.isActive = true

        UIView.animate(withDuration: 0.5) {
            self.view.window?.overrideUserInterfaceStyle = .dark
            self.popUpErrorView.superview?.layoutIfNeeded()
        }
    }
}


// MARK: - UISearchTextFieldDelegate
extension MainViewController: UISearchTextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        searchTextField.placeholder = placeholder
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.placeholder = ""
        searchTextField.sortSettingsView.alpha = 0

        // Decrease searchTextField width
        searchTextFieldWidthAnchor.isActive = false
        searchTextFieldDecreaseWidthAnchor.isActive = true
        
        UIView.animate(withDuration: 0.2) {
            self.searchTextField.leftView?.alpha = 1
            self.searchTextField.superview?.layoutIfNeeded()
         }
        
        // CancelButton appear
        UIView.animate(withDuration: 0.4) {
            self.cancelButton.alpha = 1
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchTextField.setup(rightView: .crossButton)
        searchTextField.rightView?.alpha = 1
        searchTextFieldDidChangeSelection()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.setup(rightView: .sortSettingsView)
        searchTextField.text = ""
        
        //Restore searchTextField width
        searchTextFieldDecreaseWidthAnchor.isActive = false
        searchTextFieldWidthAnchor.isActive = true
        
        UIView.animate(withDuration: 0.1, delay: 0.1) {
            self.searchTextField.leftView?.alpha = 0.3
            self.searchTextField.superview?.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            self.searchTextField.rightView?.alpha = 1
        }

        //CancelButton disappear
        UIView.animate(withDuration: 0.2) {
            self.cancelButton.alpha = 0
        }
    }
    
    private func searchTextFieldDidChangeSelection() {
        if searchTextField.text!.isEmpty {
            searchTextField.rightView?.alpha = 1
            UIView.animate(withDuration: 0.1) {
                self.searchTextField.rightView?.alpha = 0
            }
        }
        
        filterEmployeeList()
        employeesTableView.reloadData()
        checkEmployeesList()
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            self.employeesTableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.systemGray6
            self.employeesTableView.cellForRow(at: indexPath)?.backgroundColor = .clear
        }
        
        didSelectRowAt(indexPath: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let refresh = employeesTableView.refreshControl else { return }
        guard !refresh.isRefreshing else { return }
        
        employeesTableView.refreshControlView.shapeLayer.strokeEnd = -refresh.frame.minY / 136
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        employeesTableView.refreshControlView.stopAnimating()
        employeesTableView.refreshControlView.shapeLayer.strokeEnd = 0
        employeesTableView.refreshControl?.endRefreshing()
    }
    
    private func didSelectRowAt(indexPath: IndexPath) {
        var employeeList = [Employee]()
        
        if sortingMode == .birthday {
            let section = filteredTableViewSections[indexPath.section]
            employeeList = section.sectionEmployees
        } else {
            employeeList = filteredEmployeesList
        }
        
        let inputDateFormat = "yyyy-MM-dd"

        let index = indexPath.row
        let employee = employeeList[index]
        let profileViewController = ProfileViewController()
        let birthday = CoderDateFormatter(dateString: employee.birthday, inputDateFormat: inputDateFormat, outputDayFormat: .d, outputMonthFormat: .MMMM, outputYearFormat: .yyyy)
        let birthdayForAge = CoderDateFormatter(dateString: employee.birthday, inputDateFormat: inputDateFormat, outputDayFormat: .d, outputMonthFormat: .MM, outputYearFormat: .yyyy)
        
        let profileTitleContentView = profileViewController.profileTitleContentView
        let profileDetailsContentView = profileViewController.profileDetailsContentView
        
        profileTitleContentView.avatarImageView.image = UIImage(named: "goose")
        networkManager.downloadImage(url: employee.avatarUrl) { image in
            profileTitleContentView.avatarImageView.image = image
        }
        profileTitleContentView.fullNameLabel.text = employee.fullName
        profileTitleContentView.userTagLabel.text = employee.userTag.lowercased()
        profileTitleContentView.updateSubviews()
        
        switch employee.department {
        case .describing(Departments.android):
            profileTitleContentView.departmentLabel.text = Departments.android.rawValue
        case .describing(Departments.ios):
            profileTitleContentView.departmentLabel.text = Departments.ios.rawValue
        case .describing(Departments.design):
            profileTitleContentView.departmentLabel.text = Departments.design.rawValue
        case .describing(Departments.management):
            profileTitleContentView.departmentLabel.text = Departments.management.rawValue
        case .describing(Departments.qa):
            profileTitleContentView.departmentLabel.text = Departments.qa.rawValue
        case .describing(Departments.backOffice):
            profileTitleContentView.departmentLabel.text = Departments.backOffice.rawValue
        case .describing(Departments.frontend):
            profileTitleContentView.departmentLabel.text = Departments.frontend.rawValue
        case .describing(Departments.hr):
            profileTitleContentView.departmentLabel.text = Departments.hr.rawValue
        case .describing(Departments.pr):
            profileTitleContentView.departmentLabel.text = Departments.pr.rawValue
        case .describing(Departments.android):
            profileTitleContentView.departmentLabel.text = Departments.android.rawValue
        case .describing(Departments.backend):
            profileTitleContentView.departmentLabel.text = Departments.backend.rawValue
        case .describing(Departments.analytics):
            profileTitleContentView.departmentLabel.text = Departments.analytics.rawValue
        case .describing(Departments.support):
            profileTitleContentView.departmentLabel.text = Departments.support.rawValue
        default: break
        }
        
        profileDetailsContentView.birthdayLabel.text = birthday.configureWith(dateElement: [birthday.day!, birthday.month!, birthday.year!])
        profileDetailsContentView.ageLabel.text = birthdayForAge.calculateAge()
        profileDetailsContentView.phoneButton.setTitle(employee.phone, for: .normal)
        profileDetailsContentView.updateSubviews()
        
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !filteredTableViewSections.isEmpty else { return nil }

        if !filteredTableViewSections[section].sectionEmployees.isEmpty {
            if section > 0 {
                headerSectionView.yearLabel.text = filteredTableViewSections[section].yearSection
                return headerSectionView
            } else {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.heightAnchor.constraint(equalToConstant: 0).isActive = true
                return view
            }
        }

        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            return 68
        } else {
            return 22
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if sortingMode == .birthday {
            return filteredTableViewSections.count
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sortingMode == .birthday {
            return filteredTableViewSections[section].sectionEmployees.count
        }
        
        return filteredEmployeesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        employeesTableView.loadingView.isHidden = true
        headerSectionView.isHidden = false
        
        return configureEmployeesCell(for: indexPath)
    }
    
    private func configureEmployeesCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell = employeesTableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath) as! EmployeesTableViewCell
        let inputDateFormat = "yyyy-MM-dd"
        var employees = [Employee]()
        
        if sortingMode == .birthday {
            let section = filteredTableViewSections[indexPath.section]
            employees = section.sectionEmployees
            cell.birthdayLabel.isHidden = false
        } else {
            employees = filteredEmployeesList
            cell.birthdayLabel.isHidden = true
        }
        
        let employee = employees[indexPath.row]
        
        let birthday = CoderDateFormatter(dateString: employee.birthday, inputDateFormat: inputDateFormat, outputDayFormat: .d, outputMonthFormat: .MMM, outputYearFormat: .yyyy)
        
        cell.avatarImageView.image = UIImage(named: "goose")
        networkManager.downloadImage(url: employees[indexPath.row].avatarUrl) { [weak self] image in
            guard let self = self else { return }
            
            let c = employeesTableView.cellForRow(at: indexPath) as? EmployeesTableViewCell
            c?.avatarImageView.image = image
        }

        cell.fullNameLabel.text = employee.fullName
        cell.userTagLabel.text = employee.userTag.lowercased()
        cell.birthdayLabel.text = birthday.configureWith(dateElement: [birthday.day!, birthday.month!])
        
        switch employee.department {
        case .describing(Departments.android): cell.departmentLabel.text = Departments.android.rawValue
        case .describing(Departments.ios): cell.departmentLabel.text = Departments.ios.rawValue
        case .describing(Departments.design): cell.departmentLabel.text = Departments.design.rawValue
        case .describing(Departments.management): cell.departmentLabel.text = Departments.management.rawValue
        case .describing(Departments.qa): cell.departmentLabel.text = Departments.qa.rawValue
        case .describing(Departments.backOffice): cell.departmentLabel.text = Departments.backOffice.rawValue
        case .describing(Departments.frontend): cell.departmentLabel.text = Departments.frontend.rawValue
        case .describing(Departments.hr): cell.departmentLabel.text = Departments.hr.rawValue
        case .describing(Departments.pr): cell.departmentLabel.text = Departments.pr.rawValue
        case .describing(Departments.android): cell.departmentLabel.text = Departments.android.rawValue
        case .describing(Departments.backend): cell.departmentLabel.text = Departments.backend.rawValue
        case .describing(Departments.analytics): cell.departmentLabel.text = Departments.analytics.rawValue
        case .describing(Departments.support): cell.departmentLabel.text = Departments.support.rawValue
        default: break
        }
        
        return cell
    }

    private func checkEmployeesList() {
        switch sortingMode {
        case .alphabet:
            if filteredEmployeesList.isEmpty {
                employeesTableView.notFoundView.isHidden = false
                employeesTableView.loadingView.isHidden = true
            } else {
                employeesTableView.notFoundView.isHidden = true
            }
        case .birthday:
            var arr = [Bool]()

            filteredTableViewSections.forEach {section in
                arr.append(section.sectionEmployees.isEmpty)
            }
            
            if arr.contains(false) {
                employeesTableView.notFoundView.isHidden = true
            } else if arr.contains(true){
                employeesTableView.notFoundView.isHidden = false
                employeesTableView.loadingView.isHidden = true
            }
        }
    }
}

// MARK: - DepartmentSegmentedControlDelegate
extension MainViewController: DepartmentSegmentedControlDelegate {
    func set(filteringMode: FilteringMode) {
        employeesTableView.loadingView.isHidden = false
        headerSectionView.isHidden = true
        departmentFilteringMode = filteringMode
        filterEmployeeList()
        employeesTableView.reloadData()
        headerSectionView.isHidden = false
        checkEmployeesList()
    }
    
    private func filterEmployeeList() {
        switch sortingMode {
        case.alphabet:
            filteredEmployeesList = departmentSegmentedControl.filterEmployeeList(defaultEmployeeList, withDepartmentFilteringMode: departmentFilteringMode, withTextFrom: searchTextField).sorted {$0.firstName < $1.firstName}
        case .birthday:
            var sections = [SectionModel]()
            defaultTableViewSections.forEach { section in
                var sec = section
                var employees = sec.sectionEmployees
                employees = departmentSegmentedControl.filterEmployeeList(employees, withDepartmentFilteringMode: departmentFilteringMode, withTextFrom: searchTextField)
                sec.sectionEmployees = employees
                sections.append(sec)
            }
            
            filteredTableViewSections = sections
        }
    }
}

// MARK: - ModalStackViewControllerDelegate
extension MainViewController: ModalStackViewControllerDelegate {
    func sorting(isOn: Bool) {
        employeesTableView.loadingView.isHidden = false
        headerSectionView.isHidden = true
        
        searchTextField.sortSettingsView.isOn = isOn
        searchTextField.sortSettingsView.setImage()
        
        switch isOn {
        case true: sortingMode = .birthday
        case false: sortingMode = .alphabet
        }
        
        filterEmployeeList()
        checkEmployeesList()
        employeesTableView.reloadData()
    }
}

//MARK: Timer
extension MainViewController {
    func timerStart() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if self.time == 3 {
                    self.popUpErrorViewTopAnchorWhenAppear.isActive = false
                    self.popUpErrorViewTopAnchorWhenDisappear.isActive = true
                    
                    //PopUpErrorView disappear
                    UIView.animate(withDuration: 0.2) {
                        self.popUpErrorView.superview?.layoutIfNeeded()
                        self.view.window?.overrideUserInterfaceStyle = .light
                    }
                    self.timerStop()
                }
                self.time += 1
                self.employeesTableView.loadingView.isHidden = true
                self.checkEmployeesList()
                print(self.time)
            }
        }
    }
    
    func timerStop() {
        timer?.invalidate()
        timer = nil
        time = 0
    }
    
    func restartTimer() {
        timerStop()
        timerStart()
    }
}
