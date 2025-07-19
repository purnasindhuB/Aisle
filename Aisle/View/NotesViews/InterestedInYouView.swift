//
//  InterestedInYouView.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 19/07/25.
//

import UIKit

class InterestedInYouView: UIView {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let premiumLabel = UILabel()
    private let upgradeButton = UIButton(type: .system)
    private let textStack = UIStackView()
    private let mainStack = UIStackView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup UI
    private func setupViews() {
        // Title: "Interested in You"
        titleLabel.text = "Interested in You"
        titleLabel.font = Typography.font(.gilroy, weight: .medium, size: 18)
        titleLabel.textColor = .black

        // Subtitle: Premium description
        premiumLabel.text = "Premium members can view all their likes at once"
        titleLabel.font = Typography.font(.gilroy, weight: .semiBold, size: 14)
        premiumLabel.textColor = .lightGray
        premiumLabel.numberOfLines = 2

        // Vertical stack for title and subtitle
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(premiumLabel)

        // Upgrade button
        upgradeButton.setTitle("Upgrade", for: .normal)
        upgradeButton.setTitleColor(.black, for: .normal)
        upgradeButton.backgroundColor = UIColor.systemYellow
        upgradeButton.titleLabel?.font = Typography.font(.gilroy, weight: .medium, size: 18)
        upgradeButton.layer.cornerRadius = 22
        upgradeButton.setContentHuggingPriority(.required, for: .horizontal)

        // Horizontal main stack: text + button
        mainStack.axis = .horizontal
        mainStack.spacing = 12
        mainStack.alignment = .center
        mainStack.distribution = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubview(textStack)
        mainStack.addArrangedSubview(upgradeButton)

        addSubview(mainStack)
    }

    // MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            upgradeButton.heightAnchor.constraint(equalToConstant: 44),
            upgradeButton.widthAnchor.constraint(equalToConstant: 100),
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
