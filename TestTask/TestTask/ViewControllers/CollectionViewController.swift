//
//  ViewController.swift
//  TestTask
//
//  Created by Денис Мусатов on 03.10.2020.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    var rss = RSSParser()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure collectionView
        title = "Top News Today"
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
        
        //Pull to refresh init
        refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        let color = UIColor(red: 42/255, green: 94/255, blue: 129/255, alpha: 1)
        refreshControl.tintColor = color
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        refreshControl.attributedTitle = NSAttributedString(string: "Loading", attributes: attributes)
        
        collectionView.refreshControl = refreshControl
        
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rss.posts.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellView.id, for: indexPath) as! CellView
        cell.configure(with: rss.posts[indexPath.row])
        return cell
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
            
            let pickedPost = rss.posts[indexPath.row]
            pickedPost.watchPost()
            
            navigationController?.pushViewController(DetailViewController(pickedPost: pickedPost), animated: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.collectionView.reloadData()
            }
            
        }
    }
    
    @objc func refreshData(_ sender: Any) {
        self.rss = RSSParser()
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }

}
