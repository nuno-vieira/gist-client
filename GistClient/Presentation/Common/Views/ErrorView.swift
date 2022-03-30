// Copyright © 2022 nuno-vieira. All rights reserved.

import UIKit

class ErrorView: UIView {
    var retryAction: (() -> Void)?

    lazy private var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Something went wrong."
        label.textAlignment = .center
        label.textColor = AppTheme.Color.text
        return label
    }()

    lazy private var retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try Again", for: .normal)
        button.setTitleColor(AppTheme.Color.buttonTitle, for: .normal)
        button.titleLabel?.font = AppTheme.Font.body
        button.backgroundColor = AppTheme.Color.buttonBackground
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapOnRetry(_:)), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = AppTheme.Color.contentBackground

        translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorLabel)
        addSubview(retryButton)

        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 100),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 12)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func didTapOnRetry(_ sender: UIButton) {
        retryAction?()
    }
}
