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
    
    //MARK: - Lazy Private Properties
    private lazy var searchTextField = SearchTextField(placeholder: placeholder)
    private lazy var cancelButton = CancelButton()
    private lazy var departmentScrollView = DepartmentScrollView()
    private lazy var employeesTableView = EmployeesTableView()
    private lazy var headerSectionView = HeaderSectionView()
    private lazy var errorView = ErrorView(atView: view)
    private lazy var currentYear = Int(curentDate.year!)!

    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataForATableViewCell()
        setupView()
        addSubviews()
        setupLayouts()
        applyViewsCustomization()
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
        employeesTableView.loadingView.isHidden = false
        employeesTableView.notFindView.isHidden = true
        headerSectionView.isHidden = true
        fetchDataForATableViewCell()
        employeesTableView.refreshControl?.endRefreshing()
    }
    
    @objc private func repeatRequest() {
        networkManager.requestValue = .dynamicTrue
        fetchDataForATableViewCell()
        searchTextFieldDidChangeSelection()
        errorView.isHidden = true
        employeesTableView.reloadData()
    }
}

// MARK: - Network
extension MainViewController {
    func fetchDataForATableViewCell() {
        employeesTableView.loadingView.isHidden = false
        employeesTableView.notFindView.isHidden = true
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
                self.checkEmployeesList()
                self.employeesTableView.reloadData()
                self.headerSectionView.isHidden = false
            }
        }, errorComplition: {
            DispatchQueue.main.async {
                self.errorView.isHidden = false
            }
        })
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
    }
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
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
                employeesTableView.notFindView.isHidden = false
                employeesTableView.loadingView.isHidden = true
            } else {
                employeesTableView.notFindView.isHidden = true
            }
        case .birthday:
            var arr = [Bool]()

            filteredTableViewSections.forEach {section in
                arr.append(section.sectionEmployees.isEmpty)
            }
            
            if arr.contains(false) {
                employeesTableView.notFindView.isHidden = true
            } else if arr.contains(true){
                employeesTableView.notFindView.isHidden = false
                employeesTableView.loadingView.isHidden = true
            }
        }
    }
}
