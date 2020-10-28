//
//  AddSourceViewController.swift
//  TestTask
//
//  Created by Денис Мусатов on 23.10.2020.
//

import UIKit

class AddSourceViewController: UIViewController, UITextFieldDelegate {
    
    var addSourceView: AddSourceView!
    var soucesModel: SourcesModel!
    
    private var isKeyboardShown = false
    private var inputText = ""
    
    override func viewDidLoad() {
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appearKey(keyboardShowNotification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dissmisKey(keyboardShowNotification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
        
        view.backgroundColor = UIColor(named: "RSSColor")
        
        addSourceView = AddSourceView()

        addSourceView.button.addTarget(self, action: #selector(self.tapGesture(_:)), for: .touchUpInside)
        addSourceView.sampleTextField.delegate = self
        view.addSubview(addSourceView)
        
        view.anchor(width: UIScreen.main.bounds.width, height: view.bounds.height / 9 * 2)
        addSourceView.anchor(top: view.topAnchor)
        
        
        
        

    }
    @objc
    private func appearKey(keyboardShowNotification notification: Notification) {

        if !isKeyboardShown ,let userInfo = notification.userInfo,

            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            isKeyboardShown = true
            self.parent?.view.frame.origin.y += view.frame.height - keyboardRectangle.height - 50

        }
    }
    
    @objc
    private func dissmisKey(keyboardShowNotification notification: Notification) {

        if isKeyboardShown {
            isKeyboardShown = false
            self.parent?.view.frame.origin.y = 0
        }
        
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let inputText = textField.text {
            self.inputText = inputText
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        if !inputText.isEmpty {
            self.soucesModel.sources.append(self.inputText)
            self.addSourceView.sampleTextField.text = ""
            inputText = ""
        }
    }
    
}
