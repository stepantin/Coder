//
//  ModalStackViewController.swift
//  Coder
//
//  Created by Константин Степанов on 15.04.2023.
//

import UIKit

// MARK: - Protocols
protocol ModalStackViewControllerDelegate: AnyObject {
    func sorting(isOn: Bool)
}

// MARK: - ModalStackViewController
class ModalStackViewController: UIViewController {
    
    // MARK: - Delegate Property
    weak var delegate: ModalStackViewControllerDelegate?
    
    // MARK: - Private Properties
    private let alphabetSortingMethodView = SortingMethodView(withTitle: "По алфавиту")
    private let birthdaySortingMethodView = SortingMethodView(withTitle: "По дню рождения")
    private let animation = Animation()
    private let defaults = UserDefaults.standard
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupView()
        setupLayouts()
        setupGesture()
    }
}

// MARK: - Self Settings
extension ModalStackViewController {
    private func setupView() {
        title = "Сортировка"
        view.backgroundColor = .white

        updateSortingMethod(alphabetSortingMethodView, birthdaySortingMethodView)
    }
    
    private func updateSortingMethod(_ alphabet: SortingMethodView, _ birthday: SortingMethodView) {
        alphabet.isOn = UserDefaults.standard.bool(forKey: "alphabetSortingMethodViewState")
        birthday.isOn = UserDefaults.standard.bool(forKey: "birthdaySortingMethodViewState")
        
        alphabet.updateIndicatorState()
        birthday.updateIndicatorState()
    }
}

// MARK: - Add Subviews
extension ModalStackViewController {
    private func addSubviews() {
        view.addSubview(alphabetSortingMethodView)
        view.addSubview(birthdaySortingMethodView)
    }
}

// MARK: - Setup Layouts
extension ModalStackViewController {
    private func setupLayouts() {
        alphabetSortingMethodView.translatesAutoresizingMaskIntoConstraints = false
        alphabetSortingMethodView.topAnchor.constraint(equalTo: view.topAnchor, constant: 87).isActive = true
        alphabetSortingMethodView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26).isActive = true
        alphabetSortingMethodView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -26).isActive = true
        alphabetSortingMethodView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        birthdaySortingMethodView.translatesAutoresizingMaskIntoConstraints = false
        birthdaySortingMethodView.topAnchor.constraint(equalTo: view.topAnchor, constant: 147).isActive = true
        birthdaySortingMethodView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 26).isActive = true
        birthdaySortingMethodView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -26).isActive = true
        birthdaySortingMethodView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

// MARK: - Add Gesture
extension ModalStackViewController {
    private func setupGesture() {
        let tapAlphabet = UITapGestureRecognizer(target: self, action: #selector(tapAlphabetView))
        let tapBirthday = UITapGestureRecognizer(target: self, action: #selector(tapBirthdayView))
        
        alphabetSortingMethodView.addGestureRecognizer(tapAlphabet)
        alphabetSortingMethodView.isUserInteractionEnabled = true
        
        birthdaySortingMethodView.addGestureRecognizer(tapBirthday)
        birthdaySortingMethodView.isUserInteractionEnabled = true
    }
}

// MARK: - Selectors
extension ModalStackViewController {
    @objc func tapAlphabetView() {
        UIView.animate(withDuration: 0.1) {
            self.alphabetSortingMethodView.dotIndicator.layer.borderWidth = 6
            self.birthdaySortingMethodView.dotIndicator.layer.borderWidth = 2
        }
        
        defaults.set(true, forKey: "alphabetSortingMethodViewState")
        defaults.set(false, forKey: "birthdaySortingMethodViewState")

        dismiss(animated: true)
    }
    
    @objc func tapBirthdayView() {
        UIView.animate(withDuration: 0.08) {
            self.alphabetSortingMethodView.dotIndicator.layer.borderWidth = 2
            self.birthdaySortingMethodView.dotIndicator.layer.borderWidth = 6
        }
        
        defaults.set(false, forKey: "alphabetSortingMethodViewState")
        defaults.set(true, forKey: "birthdaySortingMethodViewState")
        
        dismiss(animated: true)
    }
}
