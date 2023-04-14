//
//  EmployeesTableView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class EmployeesTableView: UITableView {
    
    // MARK: - Private Methods
    private func setupTableView() {
        backgroundColor = .clear
               
    }
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero, style: .grouped)
        setupTableView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
