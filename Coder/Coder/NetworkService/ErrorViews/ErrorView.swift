//
//  ErrorView.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class ErrorView: UIView {
    
    // MARK: - Properties
    let tryAgainButton = UIButton()

    // MARK: - Private Properties
    private let UFOimageView = UIImageView(image: UIImage(named: "ufo"))
    private let someOneBrokeItLabel = UILabel()
    private let weWillTryToFixLabel = UILabel()
    private let containerView = UIView()

    // MARK: - Initializers
    init(atView view: UIView) {
        super.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))

        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .white

        addSubview(containerView)
        containerView.addSubview(UFOimageView)
        containerView.addSubview(someOneBrokeItLabel)
        containerView.addSubview(weWillTryToFixLabel)
        containerView.addSubview(tryAgainButton)

        containerView.frame.size = CGSize(width: self.frame.width, height: 150)
        containerView.layer.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

        UFOimageView.translatesAutoresizingMaskIntoConstraints = false
        UFOimageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        UFOimageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        UFOimageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        UFOimageView.heightAnchor.constraint(equalToConstant: 56).isActive = true

        someOneBrokeItLabel.text = "Какой-то сверхразум все сломал"
        someOneBrokeItLabel.font = UIFont(name: "Inter-SemiBold", size: 17)
        someOneBrokeItLabel.textColor = UIColor.setupCustomColor(.black)
        someOneBrokeItLabel.sizeToFit()
        someOneBrokeItLabel.translatesAutoresizingMaskIntoConstraints = false
        someOneBrokeItLabel.topAnchor.constraint(equalTo: UFOimageView.bottomAnchor, constant: 8).isActive = true
        someOneBrokeItLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        someOneBrokeItLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true

        weWillTryToFixLabel.text = "Постараемся быстро починить"
        weWillTryToFixLabel.font = UIFont(name: "Inter-Regular", size: 16)
        weWillTryToFixLabel.textColor = UIColor.setupCustomColor(.gray)
        weWillTryToFixLabel.sizeToFit()
        weWillTryToFixLabel.translatesAutoresizingMaskIntoConstraints = false
        weWillTryToFixLabel.topAnchor.constraint(equalTo: someOneBrokeItLabel.bottomAnchor, constant: 12).isActive = true
        weWillTryToFixLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        weWillTryToFixLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        tryAgainButton.setTitle("Попробовать снова", for: .normal)
        tryAgainButton.setTitleColor(UIColor.setupCustomColor(.violet), for: .normal)
        tryAgainButton.setTitleColor(.lightGray, for: .highlighted)
        tryAgainButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 16)
        tryAgainButton.sizeToFit()
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        tryAgainButton.topAnchor.constraint(equalTo: weWillTryToFixLabel.bottomAnchor, constant: 5).isActive = true
        tryAgainButton.centerXAnchor.constraint(equalTo: weWillTryToFixLabel.centerXAnchor).isActive = true
        tryAgainButton.heightAnchor.constraint(equalToConstant: 27).isActive = true

        isHidden = true
    }
}
