//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistListTableViewCell: UITableViewCell {
    
    var gist: Gist? = nil {
        didSet {
            guard let gist = self.gist else { return }
            commentsLabel.text = "\(String(gist.numberOfComments)) 💬"
            fileNameLabel.text = gist.files.first?.name ?? "" + ""
            createdDateLabel.text = "\(dateFormatter.string(from: gist.createdAt))"

            let owner = gist.owner
            ownerImageView.loadImage(url: owner.avatarUrl)
            ownerNameLabel.text = owner.name
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
        label.font = AppTheme.Font.subheadline
        label.textColor = AppTheme.Color.textColor
        return label
    }()

    lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTheme.Font.footnote
        label.textColor = AppTheme.Color.textColor
        return label
    }()

    lazy var fileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTheme.Font.body
        label.textColor = AppTheme.Color.boldText
        label.numberOfLines = 0
        return label
    }()
    
    lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTheme.Font.footnote
        label.textColor = AppTheme.Color.textColor
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
        backgroundColor = AppTheme.Color.contentBackgroundColor
        
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
            ownerNameLabel.topAnchor.constraint(equalTo: ownerImageView.topAnchor, constant: -4),
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
