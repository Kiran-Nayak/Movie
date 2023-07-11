//
//  Category.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import Foundation

struct Category {
    let title: String?
    let data: [CategoryData?]?
}

struct CategoryData {
    let title: String?
    let movies: [Movies?]?
}
