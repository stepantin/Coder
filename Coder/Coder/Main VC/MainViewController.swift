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
    
    // MARK: - Properties
    var sortingMode: SortingMode = .alphabet
    var departmentFilteringMode: FilteringMode = .all
    var defaultEmployeeList = [Employee]()
    var filteredEmployeesList = [Employee]()
    var defaultTableViewSections = [SectionModel]()
    var filteredTableViewSections = [SectionModel]()
    
    // MARK: - Private Properties
    private let placeholder = "Введи имя, тег, почту..."
    private let animation = Animation()
    private let sectionLine = CALayer()
    private let networkManager = NetworkManager()
    private let curentDate = CoderDateFormatter()
    private let defaults = UserDefaults.standard
    private var timer: Timer? = Timer()
    private var time = 0
    
    //MARK: - Lazy Private Properties
    private lazy var searchTextField = SearchTextField(placeholder: placeholder)
    private lazy var cancelButton = CancelButton()
    private lazy var departmentScrollView = DepartmentScrollView()
    private lazy var employeesTableView = EmployeesTableView()
    private lazy var headerSectionView = HeaderSectionView()
    private lazy var errorView = ErrorView(atView: view)
    private lazy var backButton = BackBarButtonItem()
    private lazy var currentYear = Int(curentDate.year!)!
    private lazy var popUpErrorView = PopUpErrorView()

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
        departmentScrollView.contentView.segmentedControl.delegate = self
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
        view.addSubview(departmentScrollView)
        view.layer.addSublayer(sectionLine)
        view.addSubview(employeesTableView)
        view.addSubview(errorView)
        view.addSubview(popUpErrorView)
    }
}

// MARK: - Setup Layouts
extension MainViewController {
    private func setupLayouts() {
        searchTextField.frame = CGRect(x: 16, y: 60, width: view.bounds.width - 32, height: 40)
        cancelButton.frame = CGRect(x: searchTextField.bounds.width + 40, y: 71, width: 54, height: 18)
        departmentScrollView.frame = CGRect(x: 0, y: 114, width: view.frame.width, height: 38)
        sectionLine.frame = CGRect(x: 0, y: departmentScrollView.frame.maxY, width: view.frame.width, height: 0.33)
        employeesTableView.frame = CGRect(x: 0, y: sectionLine.frame.maxY, width: view.frame.width, height: view.frame.height - sectionLine.frame.maxY)
        popUpErrorView.frame = CGRect(x: 0, y: -110, width: view.frame.width, height: 110)
    }
}

// MARK: - Views Customization
extension MainViewController {
    private func applyViewsCustomization() {
        searchTextField.crossButton.addTarget(self, action: #selector(clear), for: .allTouchEvents)
        cancelButton.addTarget(self, action: #selector(cancelEditing), for: .allTouchEvents)
        sectionLine.backgroundColor = UIColor.lightGray.cgColor
        employeesTableView.refreshControl?.addTarget(self, action: #selector(reloadEmployeeTableView), for: .valueChanged)
        errorView.tryAgainButton.addTarget(self, action: #selector(repeatRequest), for: .touchUpInside)
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
    
    @objc fileprivate func clear() {
        searchTextField.text = ""
    }
    
    @objc fileprivate func cancelEditing() {
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
    
    @objc fileprivate func presentModalStackVC() {
        animation.tap(view: searchTextField.sortSettingsView)
        
        let nc = UINavigationController()
        let modalStackViewController = ModalStackViewController()
        modalStackViewController.navigationItem.leftBarButtonItem = backButton
        backButton.target = self
        backButton.action = #selector(backToMainVC)
        nc.viewControllers = [modalStackViewController]
        modalStackViewController.delegate = self
        navigationController?.present(nc, animated: true)
    }
    
    @objc fileprivate func backToMainVC() {
        dismiss(animated: true)
    }
    
    @objc private func hidePopUpErrorView() {
        animation.popUpErrorViewDisappear(view: popUpErrorView, atViewController: self)
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
        
        networkManager.fetchData(successComplition: { employees in
            self.defaultEmployeeList = employees.items
            self.filteredEmployeesList = self.defaultEmployeeList
            
            var firstSection = SectionModel(yearSection: "", sectionEmployees: self.defaultEmployeeList)
            var secondSection = SectionModel(yearSection: "\(self.currentYear + 1)", sectionEmployees: self.defaultEmployeeList)
            firstSection.sectionEmployees = firstSection.getCurrentBirthdayYear()
            secondSection.sectionEmployees = secondSection.getNextBirthdayYearList()
            
            self.defaultTableViewSections.removeAll()
            self.defaultTableViewSections.append(firstSection)
            self.defaultTableViewSections.append(secondSection)
            
            self.filteredTableViewSections = self.defaultTableViewSections
                                    
            DispatchQueue.main.async {
                self.filterEmployeeList()
                self.checkEmployeesList()
                self.employeesTableView.reloadData()
                self.headerSectionView.isHidden = false
            }
        }) { errorDescription in
            switch errorDescription {
            case .apiError: self.errorComplition(.apiError)
            case .internetError: self.errorComplition(.internetError)
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
            self.animation.popUpErrorViewAppear(view: self.popUpErrorView, atViewController: self)
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
        animation.decreaseTextFieldWidth(textField: searchTextField, view: view)
        animation.move(cancelButton: cancelButton, bindXTo: searchTextField)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchTextField.setup(rightView: .crossButton)
        searchTextField.rightView?.alpha = 1
        searchTextFieldDidChangeSelection()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.setup(rightView: .sortSettingsView)
        searchTextField.text = ""
        animation.restoreTextFieldWidth(textField: searchTextField, view: view)
        animation.remove(cancelButton: cancelButton, bindXTo: searchTextField)
    }
    
    private func searchTextFieldDidChangeSelection() {
        if searchTextField.text!.isEmpty {
            animation.rightViewDisappears(inside: searchTextField)
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
        
        if sortingMode == .birthday {
            let section = filteredTableViewSections[indexPath.section]
            let employees = section.sectionEmployees
            employeesTableView.didSelectRowAt(indexPath: indexPath, employeeList: employees, vc: self)
        } else {
            employeesTableView.didSelectRowAt(indexPath: indexPath, employeeList: filteredEmployeesList, vc: self)
        }
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
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        employeesTableView.setViewForHeaderInSection(withView: headerSectionView, from: filteredTableViewSections, section: section, for: employeesTableView)
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
        
        let cell = employeesTableView.setupCellForRowAt(indexPath: indexPath, for: employeesTableView, with: filteredTableViewSections, at: self)
        employeesTableView.loadingView.isHidden = true
        headerSectionView.isHidden = false

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
        let departmentSegmentedControl = departmentScrollView.contentView.segmentedControl

        switch sortingMode {
        case.alphabet:
            filteredEmployeesList = departmentSegmentedControl.filterEmployeeList(self.defaultEmployeeList, withDepartmentFilteringMode: departmentFilteringMode, withTextFrom: searchTextField).sorted {$0.firstName < $1.firstName}
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
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            DispatchQueue.main.async {
                if self.time == 3 {
                    self.animation.popUpErrorViewDisappear(view: self.popUpErrorView, atViewController: self)
                    self.timerStop()
                }
                
                self.time += 1
                self.employeesTableView.loadingView.isHidden = true
                self.checkEmployeesList()
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
