//
//  BookCell.swift
//  Bookflix
//
//  Created by SEO on 15/04/2019.
//  Copyright © 2019 SEO. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BookCell: BaseCell {
    
    var book: Book? {
        didSet {
            titleLabel.text = book?.title
//            thumbnailImageView.image = UIImage(named: (book?.imageURL)!)
            setupThumbnailImage()
            
            if let libraryName = book?.subtitle, let price = book?.price {
                let subtitleText = "\(price)"
                subtitleTextView.text = subtitleText
            }
            
            //measure title text
            if let title = book?.title {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    func setupThumbnailImage() {
        if let thumbnailImage = book?.imageURL {
            print(thumbnailImage)
            self.thumbnailImageView.image = UIImage(named: thumbnailImage)
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "book_1920")
        imageView.backgroundColor = .gray
//        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "star_1280")
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        return view
    } ()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이것은 제목"
        label.numberOfLines = 2
        
        return label
    } ()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "이것은 내용내용내용 - 1,600"
        textView.textColor = .gray
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        return textView
    } ()
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
//        addSubview(userProfileImageView)
        addSubview(titleLabel)
//        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: titleLabel)
        
        // vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, titleLabel, separatorView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        
//        addConstraintsWithFormat(format: "V:[v0(20)]", views: titleLabel)
//        addConstraintsWithFormat(format: "H:[v0]", views: titleLabel)
        
        // top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        // left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 8))
        // right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        // height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint!)
//
//        // top constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
//        // left constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 8))
//        // right constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
//        // height constraint
//        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        
    }
    
    
}
