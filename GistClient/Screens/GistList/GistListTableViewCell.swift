//
//  GistListTableViewCell.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 16/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import UIKit

class GistListTableViewCell: UITableViewCell {
    
    var gist: Gist? = nil {
        didSet {
            guard let gist = self.gist else { return }
            
            if let owner = gist.owner {
                ownerImageView.loadImage(url: URL(string: owner.avatarUrl))
                ownerNameLabel.text = owner.name
            }
            if let date = gist.createdAt {
                createdDateLabel.text = "\(dateFormatter.string(from: date))"
            }
            
            commentsLabel.text = "\(String(gist.numberOfComments)) 💬"
            fileNameLabel.text = gist.filename + ""
        }
    }
    

    let imageSize = CGSize(width: 28, height: 28)

    lazy var ownerImageView: UIImageView = {
        let imageView = UIImageView()
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
        label.numberOfLines = 0
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

        NSLayoutConstraint.activate([
            ownerImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            ownerImageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            ownerImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            ownerImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            ownerNameLabel.topAnchor.constraint(equalTo: ownerImageView.topAnchor),
            ownerNameLabel.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            createdDateLabel.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor, constant: 2),
            createdDateLabel.leadingAnchor.constraint(equalTo: ownerNameLabel.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            fileNameLabel.leadingAnchor.constraint(equalTo: ownerNameLabel.leadingAnchor),
            fileNameLabel.topAnchor.constraint(equalTo: createdDateLabel.bottomAnchor, constant: 8),
            fileNameLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            commentsLabel.bottomAnchor.constraint(equalTo: fileNameLabel.bottomAnchor),
            commentsLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: 8),
            commentsLabel.leadingAnchor.constraint(equalTo: fileNameLabel.trailingAnchor, constant: 16),
            commentsLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 40)
        ])
    }
}
