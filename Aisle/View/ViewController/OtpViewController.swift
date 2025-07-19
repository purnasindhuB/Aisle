//
//  OtpViewController.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 18/07/25.
//

import UIKit

class OtpViewController: UIViewController {
    
    private let otpInputView = InputView()
    let viewModel = AuthViewModel()
    // Phone number to display and verify
    var number = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        otpInputView.startTimer() // Start OTP countdown timer
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true // Hide default back button
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(otpInputView)
        otpInputView.configure(for: .otpInput)  // Set input type to OTP
        otpInputView.topTitleLabel.text = number // Show phone number
        otpInputView.translatesAutoresizingMaskIntoConstraints = false
        
        // Layout constraints
        NSLayoutConstraint.activate([
            otpInputView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            otpInputView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            otpInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            otpInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        // Button and text change actions
        otpInputView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        otpInputView.textField.addTarget(self, action: #selector(otpNumberDidChange), for: .editingChanged)
        otpInputView.editButton.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
    }
    
    func setupBindings() {
        // On successful OTP verification
        viewModel.onOTPVerificationSuccess = { token in
            print("Token \(token)")
            UserDefaults.standard.set(token, forKey: "authToken") // Store auth token
            let notesVC = NotesViewController()
            self.navigationController?.pushViewController(notesVC, animated: true)
        }
        
        // On error
        viewModel.onError = { error in
            self.showAlert(message: error)
        }
    }
    
    @objc func otpNumberDidChange() {
        guard let otpNum = otpInputView.textField.text else { return }
        // Enable button only when OTP is 4 digits
        if otpNum.count == 4 {
            otpInputView.continueButton.isEnabled = true
            otpInputView.continueButton.alpha = 1.0
        } else {
            otpInputView.continueButton.isEnabled = false
            otpInputView.continueButton.alpha = 0.5
        }
    }
     
    @objc func continueButtonTapped() {
        // Trigger OTP verification
        guard let otp = otpInputView.textField.text else { return }
        viewModel.verifyOTP(number: number, otp: otp)
    }
    
    @objc func editTapped() {
        // Go back to previous screen to edit number
        navigationController?.popViewController(animated: true)
    }
    
    func showAlert(message: String){
        // Show error alert
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
