//
//  TopHeadlinesRequest.swift
//  NewsApp
//

import Foundation

struct TopHeadlinesRequest {
    let country: String?
    let category: TopHeadlinesCategories?
    let sources: String?
    let q: String?
    let pageSize: Int?
    let page: Int?
    let apiKey: String?
}

enum TopHeadlinesCategories {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}
