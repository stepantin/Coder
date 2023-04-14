//
//  MainViewController.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Private Properties
    private let placeholder = "Введи имя, тег, почту..."
    private let animation = Animation()
    
    //MARK: Lazy Private Properties
    private lazy var searchTextField = SearchTextField(placeholder: placeholder)

    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}

// MARK: - Add Subviews
extension MainViewController {
    private func addSubviews() {
        view.addSubview(searchTextField)
    }
}

// MARK: - Setup Layouts
extension MainViewController {
    private func setupLayouts() {
        searchTextField.frame = CGRect(x: 16, y: 60, width: view.bounds.width - 32, height: 40)
    }
}

// MARK: - Views Customization
extension MainViewController {
    private func applyViewsCustomization() {
        searchTextField.crossButton.addTarget(self, action: #selector(clear), for: .allTouchEvents)
    }
}

// MARK: - Selectors
extension MainViewController {
    
    @objc fileprivate func clear() {
        searchTextField.text = ""
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
    }
    
    private func searchTextFieldDidChangeSelection() {
        if searchTextField.text!.isEmpty {
            animation.rightViewDisappears(inside: searchTextField)
        }
    }
}
