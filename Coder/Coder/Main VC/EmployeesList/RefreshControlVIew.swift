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
        shapeLayer.strokeColor = UIColor(named: "violet")?.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = strokeEnd
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    // MARK: - Methods
    func rotation() {
        let rotaionAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotaionAnimation.duration = 1.6
        rotaionAnimation.toValue = 6.28
        rotaionAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotaionAnimation.isRemovedOnCompletion = false
        rotaionAnimation.repeatCount = .infinity
        
        layer.add(rotaionAnimation, forKey: nil)
    }
    
    func startAnimating() {
        shapeLayer.strokeEnd = 0.8

        rotation()
        
        var animations = [CABasicAnimation]()
        
        let increaseAnimation = CABasicAnimation(keyPath: "strokeEnd")
        increaseAnimation.duration = 0.8
        increaseAnimation.fromValue = 0.05
        increaseAnimation.toValue = 0.8
        increaseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        increaseAnimation.isRemovedOnCompletion = false
        animations.append(increaseAnimation)

        let decreaseAnimation = CABasicAnimation(keyPath: "strokeStart")
        decreaseAnimation.beginTime = 0.8
        decreaseAnimation.duration = 0.8
        decreaseAnimation.fromValue = 0
        decreaseAnimation.toValue = 0.75
        decreaseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        decreaseAnimation.isRemovedOnCompletion = false
        animations.append(decreaseAnimation)
        
        let group = CAAnimationGroup()
        group.duration = 1.6
        group.animations = animations
        group.fillMode = CAMediaTimingFillMode.forwards
        group.isRemovedOnCompletion = false
        group.repeatCount = .infinity
        shapeLayer.add(group, forKey: nil)
    }
    
    func stopAnimating() {
        shapeLayer.strokeEnd = 0.0
        shapeLayer.removeAllAnimations()
        layer.removeAllAnimations()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        self.transform = self.transform.rotated(by: 4.71)
    }
}

