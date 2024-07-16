//
//  FeedBackStruct.swift
//  SomeFilms
//
//  Created by Владислав Баранов on 14.07.2024.
//

import Foundation

// MARK: - FeedbackPages
struct FeedbackPages: Codable {
    let docs: [Feedback]?
    let total, limit, page, pages: Int?
}

// MARK: - Doc
struct Feedback: Codable {
    let id, movieID: Int?
    let title, type, review, date: String?
    let author: String?
    let userRating, authorID: Int?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case movieID
        case title, type, review, date, author, userRating
        case authorID
        case updatedAt, createdAt
    }
}
