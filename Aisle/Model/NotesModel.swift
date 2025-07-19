//
//  Profile.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 18/07/25.
//

import Foundation

// MARK: - Main Response Model
struct NotesResponse: Codable {
    let invites: InviteSection
    let likes: LikeSection
}

// MARK: - Invite Section Models
struct InviteSection: Codable {
    let profiles: [InviteProfile]?
}

struct InviteProfile: Codable {
    let generalInformation: GeneralInfo?
    let photos: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case generalInformation = "general_information"
        case photos
    }
}

struct GeneralInfo: Codable {
    let firstName: String?
    let age: Int?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case age
    }
}

// MARK: - Photo Model
struct Photo: Codable {
    let photo: String?
    let photoId: Int?
    let selected: Bool?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case photo
        case photoId = "photo_id"
        case selected
        case status
    }
}

// MARK: - Likes Section Models
struct LikeSection: Codable {
    let profiles: [LikeProfile]
}

struct LikeProfile: Codable {
    let firstName: String?
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case avatar
    }
}
