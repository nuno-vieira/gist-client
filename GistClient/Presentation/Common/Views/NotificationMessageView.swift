//
//  ErrorView.swift
//  GistClient
//
//  Created by Vieira, Nuno (Developer) on 20/11/2018.
//  Copyright © 2018 nuno-vieira. All rights reserved.
//

import UIKit

class NotificationMessageView: UIView {

    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = AppTheme.Font.body
        label.textColor = AppTheme.Color.textColor
        return label
    }()

    enum MessageType {
        case error, success, warning
        
        var color: UIColor {
            switch self {
            case .error:
                return AppTheme.Color.errorColor
            case .success:
                return AppTheme.Color.successColor
            case .warning:
                return AppTheme.Color.warningColor
            }
        }
    }
    
    var type: MessageType = .success {
        didSet {
            backgroundColor = type.color
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = AppTheme.Color.errorColor
        addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
