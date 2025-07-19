//
//  PhoneNumberViewController.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 18/07/25.
//

import UIKit

// Protocol to communicate phone number if needed externally
protocol PhoneNumberViewProtocol: AnyObject {
    func sendPhoneNum() -> String
}

class PhoneNumberViewController: UIViewController {
    
    // MARK: - UI & ViewModel
    private let phoneInputView = InputView()
    let viewModel = AuthViewModel()
    var delegate: PhoneNumberViewProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupActions()
        addDismissKeyboardGesture()
        setupBindings()
    }
    
    
    // Configure and add input view
    func setupLayout() {
        phoneInputView.configure(for: .phoneInput)
        phoneInputView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneInputView)
        
        NSLayoutConstraint.activate([
            phoneInputView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            phoneInputView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            phoneInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    // Add target actions to text field and button
    func setupActions() {
        phoneInputView.textField.delegate = self
        phoneInputView.textField.addTarget(self, action: #selector(phoneNumberDidChange), for: .editingChanged)
        phoneInputView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    // Bind ViewModel callbacks to UI
    private func setupBindings() {
        viewModel.onPhoneLoginSuccess = {
            let otpVc = OtpViewController()
            otpVc.number = "+91\(self.phoneInputView.textField.text!)"
            self.navigationController?.pushViewController(otpVc, animated: true)
        }
        
        viewModel.onError = { error in
            self.showAlert(message: error)
        }
    }
    
    // Handle Continue button tap
    @objc func continueButtonTapped() {
        guard let num = phoneInputView.textField.text else { return }
        viewModel.sendPhoneNumber("+91\(num)")
    }
    
    // Enable/Disable Continue button based on phone number validity
    @objc func phoneNumberDidChange() {
        guard let phoneNumber = phoneInputView.textField.text else { return }
        if isValidPhoneNumber(phoneNumber) {
            phoneInputView.continueButton.isEnabled = true
            phoneInputView.continueButton.alpha = 1.0
        } else {
            phoneInputView.continueButton.isEnabled = false
            phoneInputView.continueButton.alpha = 0.5
        }
    }
    
    // Dismiss keyboard on tap outside
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addDismissKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // Basic validation: checks for 10-digit phone number
    func isValidPhoneNumber(_ number: String) -> Bool {
        let digitsOnly = number.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneRegex = "^[0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: digitsOnly)
    }
    
    // Present simple alert
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension PhoneNumberViewController: UITextFieldDelegate {
    
    // Limit input to 10 digits and numeric only
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return allowedCharacters.isSuperset(of: characterSet) && updatedText.count <= 10
    }
}
