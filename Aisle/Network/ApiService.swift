//
//  ApiService.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 18/07/25.
//

import Foundation

/// Singleton class to handle all API calls related to authentication and user data.
class ApiService {
    static let shared = ApiService()
    private init() { }

    /// Sends phone number to the server to initiate login.
    /// - Parameters:
    ///   - number: The user's phone number.
    ///   - completion: Completion handler with result: success or failure with appropriate error.
    func sendPhoneNumber(_ number: String, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        guard let url = URL(string: API.baseURL + API.Path.phoneLogin) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["number": number]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(AuthResponse.self, from: data)
                completion(.success(true))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }

    /// Verifies OTP with the server and retrieves the authentication token.
    /// - Parameters:
    ///   - number: The user's phone number.
    ///   - otp: One-time password entered by the user.
    ///   - completion: Completion handler with result: success with token or failure with error.
    func verifyOTP(number: String, otp: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: API.baseURL + "/users/verify_otp") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["number": number, "otp": otp]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.decodingError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(AuthResponse.self, from: data)
                if let token = decoded.token {
                    completion(.success(token))
                } else {
                    completion(.failure(.noToken("Token not found")))
                }
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }

    /// Fetches notes data (profiles, invites, likes) from the server.
    /// - Parameters:
    ///   - authToken: Authorization token to authenticate the user.
    ///   - completion: Completion handler with result: success with decoded response or failure.
    func fetchNotes(authToken: String, completion: @escaping (Result<NotesResponse, NetworkError>) -> Void) {
        guard let url = URL(string: API.baseURL + API.Path.testProfileList) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authToken, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.decodingError(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(NotesResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
}
