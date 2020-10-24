//
//  Extension+UIVIewController.swift
//  TestTask
//
//  Created by Денис Мусатов on 22.10.2020.
//

import UIKit

extension UIViewController {
    func setRightNavigatonMenuButton(with action: Selector?, image: UIImage?) {
        
        let buttonSize: CGFloat = 26
        
        let newTap = UITapGestureRecognizer(target: self, action: action)
        
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: buttonSize, height: buttonSize)
        menuBtn.setImage(image, for: .normal)
        menuBtn.addGestureRecognizer(newTap)
        menuBtn.imageView?.anchor(width: buttonSize)
        menuBtn.imageView?.anchor(height: buttonSize)
        
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
}
