//
//  HierarchicalLists.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import Foundation

struct HierarchicalLists {
    var title: String
    var type: MainList?
    var poster: String?
    var language: String?
    var year: String?
    var plot: String?
    var cast: String?
    var releasedDate: String?
    var genre: String?
    var rating: [Rating?]?
}
