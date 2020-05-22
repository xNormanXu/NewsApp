//
//  SourcesRequest.swift
//  NewsApp
//

import Foundation

struct SourcesRequest {
    let category: SourcesCategories?
    let language: String?
    let country: String?
}

enum SourcesCategories {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}
