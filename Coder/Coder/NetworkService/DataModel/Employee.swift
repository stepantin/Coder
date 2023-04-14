//
//  Employee.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

struct Employee: Codable {
    let avatarUrl: String
    let birthday: String
    let department: String
    let firstName: String
    let id: String
    let lastName: String
    let phone: String
    let position: String
    let userTag: String
    var fullName: String {
        firstName + " " + lastName
    }
}
