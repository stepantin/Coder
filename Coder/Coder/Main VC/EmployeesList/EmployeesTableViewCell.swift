//
//  EmployeesTableViewCell.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

class EmployeesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var nextBirthdayYear = Int()
    
    // MARK: - Lazy Properties
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: "goose")
        avatarImageView.layer.cornerRadius = 36
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.font = .Inter(.medium, withSize: 16)
        fullNameLabel.textColor = UIColor.setupCustomColor(.black)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    lazy var departmentLabel: UILabel = {
        let departmentLabel = UILabel()
        departmentLabel.font = .Inter(.regular, withSize: 13)
        departmentLabel.textColor = UIColor.setupCustomColor(.darkGray)
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        return departmentLabel
    }()
    
    lazy var userTagLabel: UILabel = {
        let userTagLabel = UILabel()
        userTagLabel.font = .Inter(.medium, withSize: 14)
        userTagLabel.textColor = UIColor.setupCustomColor(.gray)
        userTagLabel.translatesAutoresizingMaskIntoConstraints = false
        return userTagLabel
    }()
    
    lazy var birthdayLabel: UILabel = {
        let birthdayLabel = UILabel()
        birthdayLabel.font = .Inter(.regular, withSize: 15)
        birthdayLabel.textColor = UIColor.setupCustomColor(.darkGray)
        birthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        return birthdayLabel
    }()
    
    // MARK: - Private Properties
    private let networkManager = NetworkManager()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func addSubviews() {
        selectionStyle = .none
        contentView.addSubview(avatarImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(departmentLabel)
        contentView.addSubview(userTagLabel)
        contentView.addSubview(birthdayLabel)
    }
}


