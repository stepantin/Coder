//
//  ModalStackViewController.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

class ModalStackViewController: UIViewController {
    
    // MARK:  - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

// MARK:  - Self Settings
extension ModalStackViewController {
    private func setupView() {
        title = "Сортировка"
        view.backgroundColor = .white

    }
}



