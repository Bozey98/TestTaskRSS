//
//  AddSourceView.swift
//  TestTask
//
//  Created by Денис Мусатов on 23.10.2020.
//

import UIKit

class AddSourceView: UIView {
    
    var button: UIButton!
    var sampleTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "RSSColor")
        
        sampleTextField = UITextField()
        sampleTextField.isEnabled = true
        sampleTextField.placeholder = "Enter URL to add new Source"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        sampleTextField.translatesAutoresizingMaskIntoConstraints = false
        sampleTextField.backgroundColor = UIColor(named: "RSSColor")
        addSubview(sampleTextField)
        
        button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundColor(color: UIColor(red: 33/255, green: 74/255, blue: 99/255, alpha: 1), forState: .normal)
        
        addSubview(button)
        
        setupConstraits()
        
        
    }
    
    func setupConstraits() {
        self.anchor(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 9 * 2)
        sampleTextField.anchor(top: self.topAnchor)
        sampleTextField.anchor(width: UIScreen.main.bounds.width, height: 50)
        button.anchor(top: sampleTextField.bottomAnchor, bottom: self.bottomAnchor)
        button.anchor(width: UIScreen.main.bounds.width)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        button = UIButton()
        sampleTextField = UITextField()
    }
}
