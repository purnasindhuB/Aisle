//
//  Endpoints.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 18/07/25.
//

import Foundation

enum API {
    static let baseURL = "https://app.aisle.co/V1"
    
    enum Path {
        static let phoneLogin = "/users/phone_number_login"
        static let verifyOTP = "/users/verify_otp"
        static let testProfileList = "/users/test_profile_list"
    }
}
