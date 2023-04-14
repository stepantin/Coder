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
        fullNameLabel.font = .systemFont(ofSize: 16, weight: .init(0.20))
        fullNameLabel.textColor = .black
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    lazy var departmentLabel: UILabel = {
        let departmentLabel = UILabel()
        departmentLabel.font = .systemFont(ofSize: 13, weight: .init(0.15))
        departmentLabel.textColor = .darkGray
        departmentLabel.translatesAutoresizingMaskIntoConstraints = false
        return departmentLabel
    }()
    
    lazy var userTagLabel: UILabel = {
        let userTagLabel = UILabel()
        userTagLabel.font = .systemFont(ofSize: 14, weight: .init(0.20))
        userTagLabel.textColor = .lightGray
        userTagLabel.translatesAutoresizingMaskIntoConstraints = false
        return userTagLabel
    }()
    
    lazy var birthdayLabel: UILabel = {
        let birthdayLabel = UILabel()
        birthdayLabel.font = .systemFont(ofSize: 15, weight: .init(0.15))
        birthdayLabel.textColor = .darkGray
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
    
    // MARK: - Methods
    func configureEmployeesCell(cell: EmployeesTableViewCell, for indexPath: IndexPath, with employees: [Employee]) {
        let animation = Animation()
        cell.avatarImageView.alpha = 0
        
        let employee = employees[indexPath.row]
        
        let birthday = CoderDateFormatter(dateString: employee.birthday, inputDateFormat: "yyyy-MM-dd", outputDayFormat: .d, outputMonthFormat: .MMM, outputYearFormat: .yyyy)
        
        cell.avatarImageView.image = UIImage(named: "goose")
        networkManager.downloadImage(url: employee.avatarUrl) { image in
            cell.avatarImageView.image = image
        }
        avatarImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 72).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        
        cell.fullNameLabel.text = employee.fullName
        fullNameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 104).isActive = true
        fullNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 22).isActive = true
        fullNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        cell.userTagLabel.text = employee.userTag.lowercased()
        userTagLabel.leftAnchor.constraint(equalTo: fullNameLabel.rightAnchor, constant: 4).isActive = true
        userTagLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24).isActive = true
        userTagLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
         
        cell.birthdayLabel.text = birthday.configureWith(dateElement: [birthday.day!, birthday.month!])
        birthdayLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        birthdayLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -19).isActive = true
        birthdayLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        switch employee.department {
        case "android": cell.departmentLabel.text = "Android"
        case "ios": cell.departmentLabel.text = "iOS"
        case "design": cell.departmentLabel.text = "Дизайн"
        case "management": cell.departmentLabel.text = "Менеджмент"
        case "qa": cell.departmentLabel.text = "QA"
        case "back_office": cell.departmentLabel.text = "Бэк-офис"
        case "frontend": cell.departmentLabel.text = "Frontend"
        case "hr": cell.departmentLabel.text = "HR"
        case "pr": cell.departmentLabel.text = "PR"
        case "backend": cell.departmentLabel.text = "Backend"
        case "support": cell.departmentLabel.text = "Техподдержка"
        case "analytics": cell.departmentLabel.text = "Аналитика"
        default: break
        }
        
        departmentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 104).isActive = true
        departmentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 45).isActive = true
        departmentLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        cell.backgroundColor = .clear
        animation.viewAppearWithAnimating(view: cell.avatarImageView, duration: 0.1)
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


