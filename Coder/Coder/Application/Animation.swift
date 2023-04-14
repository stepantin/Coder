//
//  Animation.swift
//  Coder
//
//  Created by Константин Степанов on 14.04.2023.
//

import UIKit

final class Animation {
        
    func tap(view: UIView) {
        UIView.animate(withDuration: 0.3) {
            view.alpha = 0
            view.alpha = 1
        }
    }
    
    func rightViewDisappears(inside textField: SearchTextField) {
        textField.rightView?.alpha = 1

        UIView.animate(withDuration: 0.1) {
            textField.rightView?.alpha = 0
        }
    }
    
    func decreaseTextFieldWidth(textField: SearchTextField, view: UIView) {
        textField.sortSettingsView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            textField.leftView?.alpha = 1
            textField.frame.size = CGSize(width: view.bounds.width - 110, height: 40)
         }
    }
    
    func restoreTextFieldWidth(textField: SearchTextField, view: UIView) {
        
        UIView.animate(withDuration: 0.1, delay: 0.1) {
            textField.leftView?.alpha = 0.3
            textField.frame.size = CGSize(width: view.bounds.width - 32, height: 40)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.1) {
            textField.rightView?.alpha = 1

        }
    }
    
}

