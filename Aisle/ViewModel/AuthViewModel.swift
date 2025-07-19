//
//  AuthViewModel.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 19/07/25.
//
import Foundation

class AuthViewModel {
    var onPhoneLoginSuccess: (() -> Void)?
    var onOTPVerificationSuccess: ((String) -> Void)?
    var onError: ((String) -> Void)?
    var onNotesFetchSuccess: (([InviteProfile], [LikeProfile]) -> Void)?

    // MARK: - Send PhoneNumber
    func sendPhoneNumber(_ number: String) {
        ApiService.shared.sendPhoneNumber(number) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let success):
                    if success {
                        self?.onPhoneLoginSuccess?()
                    } 
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    // MARK: - Verify OTP
    func verifyOTP(number:String,otp:String){
        ApiService.shared.verifyOTP(number: number, otp: otp) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self?.onOTPVerificationSuccess?(token)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
            
        }
    }
    // MARK: - Fetch Notes
    func getNotesData() {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            onError?("Missing auth token")
            return
        }

        ApiService.shared.fetchNotes(authToken: token) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let notesResponse):
                    let invites = notesResponse.invites.profiles
                    let likes = notesResponse.likes.profiles
                    self?.onNotesFetchSuccess?(invites!, likes)
                case .failure(let error):
                    self?.onError?(error.localizedDescription)
                }
            }
        }
    }
    }


