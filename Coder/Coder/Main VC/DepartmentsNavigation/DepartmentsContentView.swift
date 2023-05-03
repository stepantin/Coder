//
//  DepartmentsContentView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class DepartmentsContentView: UIView {
    
    // MARK:  - Properties
    var contentWidth: CGFloat = 0
    lazy var segmentedControl = DepartmentSegmentedControl(buttonTitles: buttonTitles)
    
    // MARK:  - Private Properties
    private let buttonTitles: [Departments] = [.all, .design, .analytics, .management, .ios, .android, .qa, .backend, .frontend, .hr, .pr, .backOffice, .support]
          
    // MARK:  - Initializers
    init() {
        super.init(frame: .zero)
         
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  - Private Methods
    private func setupView() {
        contentWidth = segmentedControl.stackWidth
        segmentedControl.frame.size = CGSize(width: segmentedControl.stackWidth, height: 36)
        
        frame = CGRect(x: 16, y: 0, width: segmentedControl.stackWidth, height: 36)
        
        addSubview(segmentedControl)
    }
}

