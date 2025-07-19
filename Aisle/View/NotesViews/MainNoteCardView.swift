//
//  MainNoteCardView.swift
//  Aisle
//

import UIKit
import SDWebImage

class MainNoteCardView: UIView {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.numberOfLines = 2
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "Gilroy-Black", size: 16)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        imageView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10)
        ])
    }

    // Load name + age + image
    func configure(with profile: InviteProfile) {
        if let firstName = profile.generalInformation?.firstName,
           let age = profile.generalInformation?.age {
            nameLabel.text = "\(firstName), \(age)\nTap to review 50+notes"
        }

        if let selectedPhoto = profile.photos?.first(where: { $0.selected == true }),
           let urlString = selectedPhoto.photo,
           let url = URL(string: urlString) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            imageView.image = UIImage(named: "placeholder")
        }
    }
}
