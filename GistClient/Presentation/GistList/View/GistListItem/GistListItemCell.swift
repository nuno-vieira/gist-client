//  Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class GistListItemCell: UITableViewCell, ReuseIdentifiable {
    
    var viewModel: GistListItemViewModel? = nil {
        didSet {
            fileNameLabel.text = viewModel?.fileNameText
            commentsLabel.text = viewModel?.commentsText
            createdAtLabel.text = viewModel?.createdAtText
            ownerNameLabel.text = viewModel?.ownerNameText
            ownerImageView.loadImage(url: viewModel?.ownerAvatarUrl)
        }
    }

    let ownerAvatarSize = CGSize(width: 28, height: 28)

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

    lazy var createdAtLabel: UILabel = {
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = AppTheme.Color.contentBackgroundColor
        
        addSubview(ownerImageView)
        addSubview(ownerNameLabel)
        addSubview(createdAtLabel)
        addSubview(fileNameLabel)
        addSubview(commentsLabel)

        NSLayoutConstraint.activate([
            ownerImageView.widthAnchor.constraint(equalToConstant: ownerAvatarSize.width),
            ownerImageView.heightAnchor.constraint(equalToConstant: ownerAvatarSize.height),
            ownerImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            ownerImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            ownerNameLabel.topAnchor.constraint(equalTo: ownerImageView.topAnchor, constant: -4),
            ownerNameLabel.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            createdAtLabel.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor, constant: 2),
            createdAtLabel.leadingAnchor.constraint(equalTo: ownerNameLabel.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            fileNameLabel.leadingAnchor.constraint(equalTo: ownerNameLabel.leadingAnchor),
            fileNameLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 8),
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
