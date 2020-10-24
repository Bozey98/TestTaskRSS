//
//  ViewController.swift
//  TestTask
//
//  Created by Денис Мусатов on 03.10.2020.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    //var rss = RSSParser()
    var sourcesModel = SourcesModel()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure collectionView
        title = RSSParser.shared.siteTitle
        self.collectionView.isUserInteractionEnabled = true
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(CellView.self, forCellWithReuseIdentifier: CellView.id)
        
        //Layout size init
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: CellView.width, height: CellView.height)
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Custom tap gesture -> standart don't work
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        
        self.collectionView.addGestureRecognizer(tap)
        
        setRightNavigatonMenuButton(with: #selector(self.handleTitleTap(_:)), image: UIImage(systemName: "slider.horizontal.3"))
       
        
        //Pull to refresh init
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        let color = UIColor(red: 42/255, green: 94/255, blue: 129/255, alpha: 1)
        refreshControl.tintColor = color
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        refreshControl.attributedTitle = NSAttributedString(string: "Loading", attributes: attributes)
        
        collectionView.refreshControl = refreshControl
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RSSParser.shared.posts.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellView.id, for: indexPath) as! CellView
        cell.configure(with: RSSParser.shared.posts[indexPath.row])
        return cell
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
            
            let pickedPost = RSSParser.shared.posts[indexPath.row]
            pickedPost.watchPost()
            
            navigationController?.pushViewController(DetailViewController(pickedPost: pickedPost), animated: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    @objc func handleTitleTap(_ sender: UITapGestureRecognizer) {
        let vc = SourceViewController()
        vc.sourcesModel = self.sourcesModel
        vc.dissMissFunc = completionFunc

        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .custom
        navController.view.backgroundColor = UIColor(named: "RSSColor")
        
        present(navController, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
        print("i am here")
        
    }
    
    func completionFunc() {
        print(RSSParser.shared.posts.count)
        self.collectionView.reloadData()
        title = RSSParser.shared.siteTitle
        
    }
    
    
    
    @objc func refreshData(_ sender: Any) {
        RSSParser.shared.updateCurrentPage()
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    

}
