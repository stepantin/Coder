//
//  SortSettingsView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class SortSettingsView: UIView {

    // MARK: - Properties
    var isOn = false
    
    // MARK: - Private Properties
    private let imageView = UIImageView()
    private let frameView = CGRect(x: 0, y: 0, width: 44, height: 40)
    private let frameImageView = CGRect(x: 10, y: 14, width: 20, height: 12)
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setImage() {
        if self.isOn {
            imageView.image = UIImage(named: "menuButton")?.withTintColor(UIColor(named: "violet")!)
        } else {
            imageView.image = UIImage(named: "menuButton")?.withTintColor(.lightGray)
        }
    }
    
    func sortingOn() {
        self.isOn = true
        
        setImage()
    }
    
    func sortingOff() {
        self.isOn = false
        
        setImage()
    }
    
    func toogleSortingState() {
        (self.isOn == true) ? (self.isOn = false) : (self.isOn = true)
        
        setImage()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        setImage()
        imageView.frame = frameImageView
        
        addSubview(imageView)
                
        frame = frameView
        layer.cornerRadius = 16
    }
}
