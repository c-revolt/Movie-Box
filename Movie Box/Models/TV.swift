//
//  TV.swift
//  Movie Box
//
//  Created by Александр Прайд on 01.06.2022.
//

import Foundation

struct TrandingTVResponse: Decodable {
    let results: [Tv]
}

struct Tv: Decodable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
