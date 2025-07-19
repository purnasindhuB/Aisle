//
//  Country.swift
//  Aisle
//
//  Created by Purnasindhu-749 on 18/07/25.
//
import Foundation
struct Country {
    let name: String
    let code: String
    let flag: String
}

struct CountryProvider {
    static let supportedCountries: [Country] = [
        Country(name: "India", code: "+91", flag: "🇮🇳"),
        Country(name: "United States", code: "+1", flag: "🇺🇸"),
        Country(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
        Country(name: "Canada", code: "+1", flag: "🇨🇦"),
        Country(name: "United Arab Emirates", code: "+971", flag: "🇦🇪"),
        Country(name: "Australia", code: "+61", flag: "🇦🇺"),
        Country(name: "Singapore", code: "+65", flag: "🇸🇬"),
        Country(name: "Malaysia", code: "+60", flag: "🇲🇾"),
        Country(name: "New Zealand", code: "+64", flag: "🇳🇿"),
        Country(name: "South Africa", code: "+27", flag: "🇿🇦")
    ]
}

