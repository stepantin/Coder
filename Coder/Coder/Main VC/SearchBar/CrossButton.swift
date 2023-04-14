//
//  CrossButton.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class CrossButton: UIButton {

    // MARK: - Properties
    private let frameButton = CGRect(x: 14.22, y: 12.22, width: 15.56, height: 15.56)
    private let image = UIImage(named: "cross")

    // MARK: - Methods
    func toView() -> UIView {
        let view = UIView()
        let frameView = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        view.frame = frameView
        view.addSubview(self)
        
        return view
    }
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupButton() {
        setImage(image?.withTintColor(.lightGray), for: .normal)
        frame = frameButton
    }
}
