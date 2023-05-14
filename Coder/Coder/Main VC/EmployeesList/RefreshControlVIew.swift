//
//  RefreshControlVIew.swift
//  Coder
//
//  Created by Константин Степанов on 16.04.2023.
//

import UIKit

class RefreshControlView: UIView {

    // MARK: - Properties
    let shapeLayer = CAShapeLayer()
    var ovalPath = UIBezierPath()
    var strokeEnd: CGFloat = 0
   
    // MARK: - Initializers
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        backgroundColor = UIColor.clear

        ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        shapeLayer.path = ovalPath.cgPath
        shapeLayer.strokeColor = UIColor.setupCustomColor(.violet).cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = strokeEnd
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    // MARK: - Methods
    
    // MARK: - Private Methods
    private func setupView() {
        self.transform = self.transform.rotated(by: 4.71)
    }
}

