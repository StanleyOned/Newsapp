//
//  NewsCell.swift
//  Newsapp
//
//  Created by Stanley Delacruz on 6/18/17.
//  Copyright © 2017 Stanley Delacruz. All rights reserved.
//

import UIKit



class NewsCell: UICollectionViewCell {
    
    var new: News? {
        didSet {
            
            titleLabel.text = new?.title
            authorLabel.text = new?.authorName
            
            if let imageUrl = new?.imageName {
                imageview.loadImageUsingUrlString(imageUrl)
            } else {
                imageview.image = #imageLiteral(resourceName: "question.png")
            }
        }
    }
    
    let imageview: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    let authorLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 14)
        return l
    }()
    
    let titleLabel: UILabel = {
        let tv = UILabel()
        tv.numberOfLines = 3
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageview)
        addSubview(authorLabel)
        addSubview(titleLabel)
        backgroundColor = .white
        
        imageview.anchor(top: topAnchor , left: leftAnchor, bottom: nil , right: nil , paddingTop: 15, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        authorLabel.anchor(top: imageview.topAnchor, left: imageview.rightAnchor, bottom: nil , right: rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 20)
        titleLabel.anchor(top: authorLabel.bottomAnchor, left: authorLabel.leftAnchor, bottom: imageview.bottomAnchor , right: authorLabel.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor(white: 0.9, alpha: 0.8)
        
        addSubview(dividerView)
        dividerView.anchor(top: nil , left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
