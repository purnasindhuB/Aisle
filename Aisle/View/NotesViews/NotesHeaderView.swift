//
//  NotesHeaderView.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 19/07/25.
//

import Foundation
import UIKit

class NotesHeaderView: UIView {
    
    // Title label: "Notes"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.font = Typography.font(.gilroy, weight: .bold, size: 27)
        label.textAlignment = .center
        return label
    }()
    
    // Subtitle label: "Personal messages to you"
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal messages to you"
        label.font = Typography.font(.gilroy, weight: .medium, size: 18)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    // StackView to arrange title and subtitle vertically
    private let stack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Setup and layout of the vertical stack
    private func setupStack() {
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
