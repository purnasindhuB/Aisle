//
//  LikeProfileCell.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 19/07/25.
//

import UIKit
import SDWebImage

class LikeProfileCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    var cornerRadius: CGFloat = 16

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Rounded corners for content and image
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Blur layer setup
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.clipsToBounds = true
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        // Name label styling
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textAlignment = .center
        nameLabel.layer.cornerRadius = 8
        nameLabel.clipsToBounds = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Shadow for card-like appearance
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.1

        // Add views
        contentView.addSubview(imageView)
        contentView.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(nameLabel)

        // Constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            nameLabel.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor, constant: -12),
            nameLabel.centerXAnchor.constraint(equalTo: blurEffectView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }

    // Bind profile data to cell
    func configure(with profile: LikeProfile) {
        nameLabel.text = profile.firstName ?? ""
        if let avatarURL = profile.avatar, let url = URL(string: avatarURL) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            blurEffectView.effect = UIBlurEffect(style: .light)
        }
    }
}

// Update shadow path when layout changes
extension LikeProfileCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
}
