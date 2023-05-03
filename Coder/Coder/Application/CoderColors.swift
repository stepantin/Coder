//
//  CoderColors.swift
//  Coder
//
//  Created by Константин Степанов on 28.04.2023.
//

import UIKit

enum CoderColors {
    case black
    case lightGray
    case gray
    case darkGray
    case extraLightGray
    case violet
    case red
}

extension UIColor {
    static func setupCustomColor(_ color: CoderColors) -> UIColor {
        switch color {
        case .black: return UIColor(named: "coderBlack") ?? .black
        case .lightGray: return UIColor(named: "coderLightGray") ?? .lightGray
        case .gray: return UIColor(named: "coderGray") ?? .gray
        case .darkGray: return UIColor(named: "coderDarkGray") ?? .darkGray
        case .extraLightGray: return UIColor(named: "coderExtraLightGray") ?? .white
        case .violet: return UIColor(named: "coderViolet") ?? .blue
        case .red: return UIColor(named: "coderRed") ?? .red
        }
    }
}
