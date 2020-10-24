//
//  TableViewController.swift
//  TestTask
//
//  Created by Денис Мусатов on 23.10.2020.
//

import UIKit

class TableViewController: UITableViewController {
    
    var sourcesModel: SourcesModel!
    var dissMissFunc: (() -> Void)!

    let cellId = "cellId"
    
    

    override func viewDidLoad() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        view.anchor(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 9 * 7)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sourcesModel.sources.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = self.sourcesModel.sources[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.sourcesModel.changeSource(id: indexPath.row)
        RSSParser.shared.reloadData(with: sourcesModel.currentSource)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dissMissFunc()
    }
}
