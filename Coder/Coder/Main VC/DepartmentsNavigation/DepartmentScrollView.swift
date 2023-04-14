//
//  DepartmentScrollView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class DepartmentScrollView: UIScrollView {
    
    // MARK: - Properties
    var contentView = DepartmentsContentView()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupView() {
        contentSize = CGSize(width: contentView.contentWidth + 36, height: 36)
        showsHorizontalScrollIndicator = false
        bounces = false
        
        addSubview(contentView)
    }
}
