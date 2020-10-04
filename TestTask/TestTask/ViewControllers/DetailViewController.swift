//
//  DetailViewController.swift
//  TestTask
//
//  Created by Денис Мусатов on 04.10.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    var post: Post
    
    //Texts views init
    private var titleView: UITextView = {
        let titleView = UITextView()
        titleView.standartSetup(ofSize: 30)

        return titleView
        
    }()
    
    private var dateView: UITextView = {
        let dateView = UITextView()
        dateView.standartSetup(ofSize: 12)
        
        return dateView
        
    }()
    
    private var descriptionView : UITextView = {
        let descriptionView = UITextView()
        descriptionView.standartSetup(ofSize: 20)
        
        return descriptionView
        
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        let scroll = UIScrollView(frame: view.frame)
        scroll.backgroundColor = .white
        view.addSubview(scroll)
        
        let collectionView = UIStackView(arrangedSubviews: [titleView, dateView, descriptionView])
        collectionView.backgroundColor = .white
        collectionView.axis = .vertical
        collectionView.frame = CGRect(x: 0, y: 0, width: CellView.width, height: getHeight(scrollView: scroll))
        
        scroll.addSubview(collectionView)
        scroll.contentSize = CGSize(
            width: view.frame.width,
            height: collectionView.sizeThatFits(view.sizeThatFits(collectionView.frame.size)).height
        )
        
        setElementsPositions(scrollView: scroll)
          
    }
    
    init(pickedPost: Post) {
        self.post = pickedPost
        descriptionView.text = post.description
        titleView.text = post.title
        dateView.text = post.pubDate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.post = Post()
        super.init(coder: coder)
    }
    
    //Set postion of all elements
    private func setElementsPositions(scrollView: UIScrollView) {
        titleView.anchor(top: scrollView.topAnchor)
        dateView.anchor(top: titleView.bottomAnchor)
        descriptionView.anchor(top: dateView.bottomAnchor)
        
    }
    
    //Get height of all content
    func getHeight(scrollView: UIScrollView) -> CGFloat {
        let titleSize = titleView.sizeThatFits(scrollView.sizeThatFits(titleView.frame.size)).height
        let dateSize = dateView.sizeThatFits(scrollView.sizeThatFits(dateView.frame.size)).height
        let descriptionSize = descriptionView.sizeThatFits(scrollView.sizeThatFits(descriptionView.frame.size)).height
        
        return titleSize + dateSize + descriptionSize
    }
    
}
