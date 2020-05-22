//
//  SourcesNewsMode.swift
//  NewsApp
//

import Foundation

// MARK: - SourcesDetail
struct SourcesDetail: Codable {
    let status: String
    let sources: [Sources]
}

// MARK: - Sources
struct Sources: Codable {
    let id, name, sourceDescription: String
    let url: String
    let category: Category
    let language, country: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, language, country
    }
}

enum Category: String, Codable {
    case business = "business"
    case entertainment = "entertainment"
    case general = "general"
    case health = "health"
    case science = "science"
    case sports = "sports"
    case technology = "technology"
}
