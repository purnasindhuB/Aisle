//
//  LikesCarouselView.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 19/07/25.
//

import UIKit

class LikesCarouselView: UIView {

    // MARK: - Properties
    private let collectionView: UICollectionView

    // Array of liked profiles to display
    var profiles: [LikeProfile] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        // Set up horizontal layout for carousel
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 168, height: 350)
        layout.minimumLineSpacing = 16

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setupViews() {
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        // Register custom cell
        collectionView.register(LikeProfileCell.self, forCellWithReuseIdentifier: "LikeCell")

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        // Pin collectionView to edges of the view
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension LikesCarouselView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profiles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCell", for: indexPath) as! LikeProfileCell
        let profile = profiles[indexPath.item]
        cell.configure(with: profile)
        return cell
    }
}
