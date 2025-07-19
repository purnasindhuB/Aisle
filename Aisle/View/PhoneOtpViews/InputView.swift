//
//  InputView.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 19/07/25.
//

import UIKit

class InputView: UIView {
    
    // MARK: - UI Components
    let topTitleLabel = UILabel()
    let titleLabel = UILabel()
    let countryCodeButton = UIButton(type: .system)
    let textField = UITextField()
    let continueButton = UIButton(type: .system)
    let editButton = UIButton(type: .system)
    private let timerLabel = UILabel()
    
    private let containerStack = UIStackView()
    private var timer: Timer?
    private var remainingSeconds = 0

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupViews()
        layoutStack()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Setup
    private func setupViews() {
        // Top Title
        topTitleLabel.font = UIFont(name: "Inter-Bold", size: 18) ?? .boldSystemFont(ofSize: 18)
        topTitleLabel.numberOfLines = 1
        topTitleLabel.textColor = .black

        // Main Title
        titleLabel.font = UIFont(name: "Inter-Bold", size: 26) ?? .boldSystemFont(ofSize: 26)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black

        // TextField
        textField.font = UIFont(name: "Inter-Regular", size: 16) ?? .systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 140).isActive = true

        // Country Code Button
        countryCodeButton.setTitle("🇮🇳 +91", for: .normal)
        countryCodeButton.setTitleColor(.black, for: .normal)
        countryCodeButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 16) ?? .systemFont(ofSize: 16)
        countryCodeButton.layer.borderWidth = 1
        countryCodeButton.layer.borderColor = UIColor.darkGray.cgColor
        countryCodeButton.layer.cornerRadius = 8
        countryCodeButton.widthAnchor.constraint(equalToConstant: 67).isActive = true
        countryCodeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true

        // Edit Button
        editButton.setImage(UIImage(named: "edit"), for: .normal)
        editButton.tintColor = .black
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 30).isActive = true

        // Continue Button
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.black, for: .normal)
        continueButton.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14) ?? .boldSystemFont(ofSize: 14)
        continueButton.backgroundColor = UIColor.systemYellow
        continueButton.layer.cornerRadius = 22
        continueButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        continueButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

        // Timer Label
        timerLabel.font = UIFont(name: "Inter-Bold", size: 13) ?? .boldSystemFont(ofSize: 13)
        timerLabel.textColor = .black
        timerLabel.textAlignment = .center
        timerLabel.isHidden = true
        timerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    // MARK: - Layout
    private func layoutStack() {
        let titleStack = UIStackView(arrangedSubviews: [topTitleLabel, editButton])
        titleStack.axis = .horizontal
        titleStack.alignment = .leading
        titleStack.spacing = 10

        let phoneStack = UIStackView(arrangedSubviews: [countryCodeButton, textField])
        phoneStack.axis = .horizontal
        phoneStack.spacing = 10
        phoneStack.alignment = .leading

        let timerStack = UIStackView(arrangedSubviews: [continueButton, timerLabel])
        timerStack.axis = .horizontal
        timerStack.alignment = .center
        timerStack.spacing = 10

        containerStack.axis = .vertical
        containerStack.spacing = 20
        containerStack.alignment = .leading

        [titleStack, titleLabel, phoneStack, timerStack].forEach {
            containerStack.addArrangedSubview($0)
        }

        addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerStack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -40)
        ])
    }

    // MARK: - Configuration
    func configure(for type: InputViewType) {
        switch type {
        case .phoneInput:
            topTitleLabel.text = "Get OTP"
            titleLabel.text = "Enter your\nPhone Number"
            editButton.isHidden = true
            textField.placeholder = "9999999999"
            countryCodeButton.isHidden = false
            timerLabel.isHidden = true
        case .otpInput:
            topTitleLabel.text = ""
            titleLabel.text = "Enter the\nOTP"
            editButton.isHidden = false
            textField.placeholder = "9999"
            countryCodeButton.isHidden = true
            timerLabel.isHidden = false
        }
    }

    // MARK: - Timer
    func startTimer(duration: Int = 60) {
        timer?.invalidate()
        remainingSeconds = duration
        timerLabel.isHidden = false
        updateTimerLabel()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.remainingSeconds -= 1
            self.updateTimerLabel()

            if self.remainingSeconds <= 0 {
                self.timer?.invalidate()
                self.timerLabel.text = "Resend OTP"
            }
        }
    }

    private func updateTimerLabel() {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }

    deinit {
        timer?.invalidate()
    }
}
