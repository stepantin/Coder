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
    private let cellReuseIdentifier = "employeeCell"
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
    
    // MARK: - Private Methods
    private func setupTableView() {
        backgroundColor = .clear
        register(EmployeesTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
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
