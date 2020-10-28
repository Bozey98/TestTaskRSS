//
//  SourceViewController.swift
//  TestTask
//
//  Created by Денис Мусатов on 22.10.2020.
//

import UIKit


class SourceViewController: UIViewController {

    private var tableVC = TableViewController()
    private var addSourceVC = AddSourceViewController()
    
    var sourcesModel: SourcesModel!
    var dissMissFunc: (() -> Void)!
    
    
    override func viewDidLoad() {
        
        title = "Sources"
        setRightNavigatonMenuButton(with: #selector(backButtonAction), image: UIImage(systemName: "xmark"))
        view.backgroundColor = UIColor(named: "RSSColor")

        
        tableVC.sourcesModel = sourcesModel
        tableVC.dissMissFunc = dissMissFunc
        addChild(tableVC)
        
        addSourceVC.soucesModel = sourcesModel
        addChild(addSourceVC)
       
        view.addSubview(tableVC.view)
        view.addSubview(addSourceVC.view)
        
        
        tableVC.view.anchor(top: view.topAnchor)
        addSourceVC.view.anchor(bottom: view.bottomAnchor)
        
        
        tableVC.didMove(toParent: self)
        addSourceVC.didMove(toParent: self)
        
        
    }
    
    
    @objc func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
}





