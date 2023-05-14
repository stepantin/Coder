//
//  EmployeesTableView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class EmployeesTableView: UITableView {
    
    // MARK: - Properties
    let tableViewRefreshControl = UIRefreshControl()
    let notFoundView = NotFoundView()
    let refreshControlView = RefreshControlView()
    
    // MARK: - Private Properties
    private let loadingView = UIView()
    private let cellReuseIdentifier = "employeeCell"
    private let listLoadingStackView = UIStackView()
    private let networkManager = NetworkManager()
    private let animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.duration = 0.5
        animation.fromValue = 1
        animation.toValue = 0.2
        animation.repeatCount = .infinity
        animation.autoreverses = true
        return animation
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero, style: .grouped)
        
        setupTableView()
        startLoadingAnimating()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func startRefreshAnimating() {
        refreshControlView.shapeLayer.strokeEnd = 0.8

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
        refreshControlView.shapeLayer.add(group, forKey: nil)
    }
    
    func stopRefreshAnimating() {
        refreshControlView.shapeLayer.strokeEnd = 0.0
        refreshControlView.shapeLayer.removeAllAnimations()
        refreshControlView.layer.removeAllAnimations()
    }
    
    
    func startLoadingAnimating() {
        loadingView.isHidden = false
        listLoadingStackView.layer.add(animation, forKey: nil)
    }
    
    func stopLoadingAnimating() {
        loadingView.isHidden = true
        listLoadingStackView.layer.removeAllAnimations()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        backgroundColor = .clear
        register(EmployeesTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        rowHeight = 86
        separatorStyle = .none
        sectionFooterHeight = 0
        
        refreshControl = tableViewRefreshControl
        tableViewRefreshControl.tintColor = .clear
        tableViewRefreshControl.addSubview(refreshControlView)
        
        refreshControlView.translatesAutoresizingMaskIntoConstraints = false
        refreshControlView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        refreshControlView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        refreshControlView.centerXAnchor.constraint(equalTo: tableViewRefreshControl.centerXAnchor).isActive = true
        refreshControlView.topAnchor.constraint(equalTo: tableViewRefreshControl.centerYAnchor).isActive = true
        
        configStackView()

        addSubview(notFoundView)
        addSubview(loadingView)
        
        notFoundView.translatesAutoresizingMaskIntoConstraints = false
        notFoundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        notFoundView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        notFoundView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        notFoundView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        loadingView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: listLoadingStackView.bottomAnchor).isActive = true
        loadingView.backgroundColor = .white
    }
    
    private func configStackView() {
        loadingView.addSubview(listLoadingStackView)
       
        listLoadingStackView.axis = .vertical
        listLoadingStackView.spacing = 86
        
        for _ in 1...20 {
            let listLoadingView = LoadingView()
            listLoadingStackView.addArrangedSubview(listLoadingView)
        }
        
        listLoadingStackView.layer.position.y = 12
        listLoadingStackView.frame.size.height = 1634
    }
    
    private func rotation() {
        let rotaionAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotaionAnimation.duration = 1.6
        rotaionAnimation.toValue = 6.28
        rotaionAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotaionAnimation.isRemovedOnCompletion = false
        rotaionAnimation.repeatCount = .infinity
        
        refreshControlView.layer.add(rotaionAnimation, forKey: nil)
    }
}
