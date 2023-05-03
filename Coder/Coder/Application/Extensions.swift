//
//  Extensions.swift
//  Coder
//
//  Created by Константин Степанов on 03.05.2023.
//

import UIKit

extension String {
    static func describing<Subject>(_ subject: Subject) -> String {
        return String(describing: subject)
    }
}

extension UIFont {
    static func Inter(_ style: Inter, withSize size: CGFloat) -> UIFont? {
        if let font =  UIFont(name: .describing(style.rawValue), size: size) {
            return font
        } else {
            return nil
        }
    }
}
