//
//  NetworkError.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 18/07/25.
//

import Foundation

enum NetworkError : Error{
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case statusCode(Int)
    case decodingError(Error)
    case noData
    case noToken(String)
}
