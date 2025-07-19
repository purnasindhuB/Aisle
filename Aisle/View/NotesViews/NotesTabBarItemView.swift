//
//  CustomBottomTabBar.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 19/07/25.
//

import UIKit

class TabBarItemView: UIView {
    
    // MARK: - UI Elements
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let badgeLabel = UILabel()
    
    // MARK: - Init
    init(image: UIImage, title: String, badgeCount: String? = nil) {
        super.init(frame: .zero)
        setupUI(image: image, title: title, badgeCount: badgeCount)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup UI
    private func setupUI(image: UIImage, title: String, badgeCount: String?) {
        // Icon setup
        iconImageView.image = image.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = .gray
        iconImageView.translatesAutoresizingMaskIntoConstraints = false

        // Title setup
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Badge setup
        badgeLabel.text = badgeCount
        badgeLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = .purple
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 10
        badgeLabel.clipsToBounds = true
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.isHidden = badgeCount == nil

        // Add subviews
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(badgeLabel)

        // Layout constraints
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 25),
            iconImageView.heightAnchor.constraint(equalToConstant: 25),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 2),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            
            badgeLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -5),
            badgeLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -10),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    // MARK: - Update Methods

    /// Show or hide badge with updated value
    func updateBadge(_ value: String?) {
        badgeLabel.text = value
        badgeLabel.isHidden = value == nil
    }

    /// Toggle selected state (updates tint color)
    func setSelected(_ selected: Bool) {
        let color: UIColor = selected ? .black : .gray
        iconImageView.tintColor = color
        titleLabel.textColor = color
    }
}
