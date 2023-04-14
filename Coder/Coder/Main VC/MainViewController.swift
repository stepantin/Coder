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
    private lazy var cancelButton = CancelButton()

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
        view.addSubview(cancelButton)

    }
}

// MARK: - Setup Layouts
extension MainViewController {
    private func setupLayouts() {
        searchTextField.frame = CGRect(x: 16, y: 60, width: view.bounds.width - 32, height: 40)
        cancelButton.frame = CGRect(x: searchTextField.bounds.width + 40, y: 71, width: 54, height: 18)
    }
}

// MARK: - Views Customization
extension MainViewController {
    private func applyViewsCustomization() {
        searchTextField.crossButton.addTarget(self, action: #selector(clear), for: .allTouchEvents)
        cancelButton.addTarget(self, action: #selector(cancelEditing), for: .allTouchEvents)

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
