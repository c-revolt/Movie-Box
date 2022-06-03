//
//  YouTubeSearch.swift
//  Movie Box
//
//  Created by Александр Прайд on 03.06.2022.
//

import Foundation


struct YouTubeSearch: Decodable {
    let items: [YTVideo]
}

struct YTVideo: Decodable {
    let id: VideoID
}

struct VideoID: Decodable {
    let kind: String
    let videoId: String
}
