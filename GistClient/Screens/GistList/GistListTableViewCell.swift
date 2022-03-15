//
//  GistListTableViewCell.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 16/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class GistListTableViewCell: UITableViewCell {
    
    var gist: Gist? = nil {
        didSet {
            guard let gist = self.gist else { return }
            
            if let owner = gist.owner {
                ownerImageView.kf.setImage(with: URL(string: owner.avatarUrl))
                ownerNameLabel.text = owner.name
            }
            if let date = gist.createdAt {
                createdDateLabel.text = "\(dateFormatter.string(from: date))"
            }
            
            commentsLabel.text = "\(String(gist.numberOfComments)) comments"
            fileNameLabel.text = gist.filename + ""
        }
    }
    

    let imageSize = CGSize(width: 28, height: 28)

    lazy var ownerImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: imageSize))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()

    lazy var ownerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .Theme.textColor
        return label
    }()

    lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .Theme.textColor
        return label
    }()

    lazy var fileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .Theme.boldText
        label.numberOfLines = 1
        return label
    }()
    
    lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .Theme.textColor
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.Theme.contentBackgroundColor
        
        addSubview(ownerImageView)
        addSubview(ownerNameLabel)
        addSubview(createdDateLabel)
        addSubview(fileNameLabel)
        addSubview(commentsLabel)
        
        ownerImageView.snp.makeConstraints { (make) in
            make.size.equalTo(imageSize.width)
            make.left.equalTo(self.layoutMargins.left).offset(10)
            make.top.equalTo(self.layoutMargins.top)
        }
        
        ownerNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ownerImageView.snp.top).offset(-1)
            make.left.equalTo(ownerImageView.snp.right).offset(12)
        }
        
        createdDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(ownerNameLabel.snp.bottom).offset(2)
            make.left.equalTo(ownerNameLabel.snp.left)
        }
        
        fileNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(ownerNameLabel.snp.left)
            make.top.equalTo(createdDateLabel.snp.bottom).offset(7)
            make.bottom.lessThanOrEqualTo(layoutMargins.bottom).offset(-6)
        }
        
        commentsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(20)
            make.right.equalTo(layoutMargins.right).offset(-10)
            make.left.greaterThanOrEqualTo(fileNameLabel.snp.right).offset(2)
            make.width.greaterThanOrEqualTo(80)
        }
    }

}
