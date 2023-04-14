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
    let notFindView = NotFindView()
    
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
    
    // MARK: - Private Methods
    private func setupTableView() {
        backgroundColor = .clear
        register(EmployeesTableViewCell.self, forCellReuseIdentifier: "employeeCell")
        rowHeight = 86
        separatorStyle = .none
        
        tableViewRefreshControl.tintColor = .black
        refreshControl = tableViewRefreshControl
        
        configStackView()

        addSubview(notFindView)
        addSubview(loadingView)
        
        notFindView.translatesAutoresizingMaskIntoConstraints = false
        notFindView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        notFindView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        notFindView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        notFindView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
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
