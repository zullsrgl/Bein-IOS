//
//  .movie.swift
//  BeinConnectIOS
//
//  Created by Zülal Sarıoğlu on 4.12.2023.
//

import Foundation

struct MovieDetail : Codable {
    let id: Int
    let original_title: String?
    let poster_path: String?
    let release_date: String?
    let vote_average: Double?
    let overview: String?

}
