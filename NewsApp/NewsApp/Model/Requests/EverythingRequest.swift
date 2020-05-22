//
//  EverythingRequest.swift
//  NewsApp
//

import Foundation

struct EverythingRequest {
    let q: String?
    let qInTitle: String?
    let sources: String?
    let domains: String?
    let excludeDomains: String?
    let from: Date?
    let to: Date?
    let language: String?
    let sortBy: EverythingSortBy?
    let pageSize: Int?
    let page: Int?
    let apiKey: String?
}

enum EverythingSortBy {
    case relevancy
    case popularity
    case publishedAt
}
