//
//  CellView.swift
//  TestTask
//
//  Created by Денис Мусатов on 03.10.2020.
//

import UIKit

class CellView: UICollectionViewCell {
    
    //Fonts depends of screen size
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height / 6
    static let largeFont = height / 7.5
    static let smallFont = height / 12.5
    
    static let id = "CircleViewCell"
    
    var post = Post()
    
    //Text views init
    private var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.text = ""
        textView.textColor = .black
        textView.backgroundColor = .none
        textView.font = UIFont.systemFont(ofSize: largeFont)
        
        return textView
        
    }()
    
    private var dateView: UITextView = {
        let dateView = UITextView()
        dateView.translatesAutoresizingMaskIntoConstraints = false
        dateView.isScrollEnabled = false
        dateView.isEditable = false
        dateView.text = ""
        dateView.textColor = .black
        dateView.backgroundColor = .none
        dateView.font = UIFont.systemFont(ofSize: smallFont)
        
        return dateView
        
    }()
    
    private var isWatchedView: UITextView = {
        let watchView = UITextView()
        watchView.translatesAutoresizingMaskIntoConstraints = false
        watchView.isScrollEnabled = false
        watchView.isEditable = false
        watchView.text = ""
        watchView.textColor = .black
        watchView.backgroundColor = .none
        watchView.font = UIFont.systemFont(ofSize: smallFont)
        
        return watchView
        
    }()
    
    private var collectionView: UIStackView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        
        collectionView = UIStackView(arrangedSubviews: [dateView, textView, isWatchedView])
        collectionView.frame = CGRect(x: 0, y: 0, width: CellView.width, height: CellView.height)
        
        collectionView.backgroundColor = .white
        collectionView.axis = .vertical
        
        contentView.addSubview(collectionView)
        
        setElementsPositions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //Set velues from posts array
    public func configure(with post: Post) {
        self.post = post
        textView.text = post.title
        dateView.text = post.pubDate
        isWatchedView.text = post.isWatched ? "Просмотрено" : ""
        
    }
    
    //Set position of all elements
    private func setElementsPositions() {
        
        dateView.anchor(top: collectionView.topAnchor)
        
        textView.anchor(
            top: collectionView.topAnchor,
            paddingTop: dateView.sizeThatFits(sizeThatFits(dateView.frame.size)).height / 1.4,
            width: CellView.width,
            height: CellView.height / 1.7
        )
        
        isWatchedView.anchor(bottom: collectionView.bottomAnchor, right: collectionView.rightAnchor, paddingBottom: 5, paddingRight: 5)
        isWatchedView.textAlignment = .right
    }
}
