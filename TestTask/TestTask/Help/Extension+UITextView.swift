//
//  Extension+UITextView.swift
//  TestTask
//
//  Created by Денис Мусатов on 05.10.2020.
//

import UIKit

extension UITextView {
    func standartSetup(withText: String = "", ofSize: CGFloat = 10) {
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isScrollEnabled = false
        self.isEditable = false
        self.text = withText
        self.textColor = .black
        self.backgroundColor = .none
        self.font = UIFont.systemFont(ofSize: ofSize)
    }
}
