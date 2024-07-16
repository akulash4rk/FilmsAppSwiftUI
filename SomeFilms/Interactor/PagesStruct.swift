// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let pages = try? JSONDecoder().decode(Pages.self, from: jsonData)


import Foundation

// MARK: - Pages
struct Pages: Codable {
    let docs: [Doc]?
    let total, limit, page, pages: Int?
}

// MARK: - Doc
struct Doc: Codable {
    let id: Int?
    let externalID: ExternalID?
    let name: String?
    let alternativeName, enName: String?
    let names: [Name]?
    let type: TypeEnum?
    let typeNumber: Int?
    let year: Int?
    let description, shortDescription: String?
    let slogan: String?
    let status: Status?
    let rating: Rating?
    let votes: Votes?
    let movieLength, totalSeriesLength, seriesLength: Int?
    let ratingMPAA: RatingMPAA?
    let ageRating: Int?
    let poster, backdrop: Backdrop?
    let genres, countries: [Country]?
    let persons: [Person]?
    let budget: Budget?
    let premiere: Premiere?
    let sequelsAndPrequels: [SequelsAndPrequel]?
    let watchability: Watchability?
    let top10, top250: Int?
    let isSeries: Bool?
    let audience: [Audience]?
    let ticketsOnSale: Bool?
    let lists: [String]?
    let networks: Networks?
    let createdAt, updatedAt: String?
    let videos: Videos?
    let fees: Fees?
    let facts: [Fact]?
    let logo: Backdrop?
    let reviewInfo: ReviewInfo?
    let seasonsInfo: [SeasonsInfo]?
    let similarMovies: [SequelsAndPrequel]?
    let releaseYears: [ReleaseYear]?
    let isFake: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case externalID
        case name, alternativeName, enName, names, type, typeNumber, year, description, shortDescription, slogan, status, rating, votes, movieLength, totalSeriesLength, seriesLength
        case ratingMPAA
        case ageRating, poster, backdrop, genres, countries, persons, budget, premiere, sequelsAndPrequels, watchability, top10, top250, isSeries, audience, ticketsOnSale, lists, networks, createdAt, updatedAt, videos, fees, facts, logo, reviewInfo, seasonsInfo, similarMovies, releaseYears, isFake
    }
}

// MARK: - Audience
struct Audience: Codable {
    let count: Int?
    let country: String?
}

// MARK: - Backdrop
struct Backdrop: Codable {
    let url, previewURL: String?

    enum CodingKeys: String, CodingKey {
        case url
        case previewURL
    }
}

// MARK: - Budget
struct Budget: Codable {
    let currency: String?
    let value: Int?
}

// MARK: - Country
struct Country: Codable {
    let name: String?
}

// MARK: - ExternalID
struct ExternalID: Codable {
    let kpHD, imdb: String?
    let tmdb: Int?
}

// MARK: - Fact
struct Fact: Codable {
    let value, type: Percentage?
    let spoiler: Bool?
}

enum Percentage: String, Codable {
    case movie
    case string
}

// MARK: - Fees
struct Fees: Codable {
    let usa, world, russia: Budget?
}

// MARK: - Name
struct Name: Codable {
    let name: String?
    let language, type: String?
    let nameSet: Set?

    enum CodingKeys: String, CodingKey {
        case name, language, type
        case nameSet
    }
}

// MARK: - Set
struct Set: Codable {
    let language: String?
    let type: String?
}

// MARK: - Networks
struct Networks: Codable {
    let items: [NetworksItem]?
}

// MARK: - NetworksItem
struct NetworksItem: Codable {
    let name: String?
    let logo: Logo?
}

// MARK: - Logo
struct Logo: Codable {
    let url: String?
}

// MARK: - Person
struct Person: Codable {
    let id: Int?
    let photo: String?
    let name, enName, description: String?
    let profession, enProfession: String?
}

// MARK: - Premiere
struct Premiere: Codable {
    let country: String?
    let digital: Percentage?
    let cinema: String?
    let bluray, dvd, russia, world: String?
}

// MARK: - Rating
struct Rating: Codable {
    let kp, imdb, filmCritics, russianFilmCritics: Double?
    let ratingAwait: Double?
    let tmdb: Double?

    enum CodingKeys: String, CodingKey {
        case kp, imdb, filmCritics, russianFilmCritics
        case ratingAwait
        case tmdb
    }
}

enum RatingMPAA: String, Codable {
    case g = "g"
    case pg = "pg"
    case pg13 = "pg13"
    case r = "r"
}

// MARK: - ReleaseYear
struct ReleaseYear: Codable {
    let start: Int?
    let end: Int?
}

// MARK: - ReviewInfo
struct ReviewInfo: Codable {
    let count, positiveCount: Int?
    let percentage: Percentage?
}

// MARK: - SeasonsInfo
struct SeasonsInfo: Codable {
    let number, episodesCount: Int?
}

// MARK: - SequelsAndPrequel
struct SequelsAndPrequel: Codable {
    let id: Int?
    let name, alternativeName: String?
    let enName: Percentage?
    let type: Percentage?
    let poster: Backdrop?
    let rating: Rating?
    let year: Int?
}

enum Status: String, Codable {
    case completed = "completed"
    case postProduction = "post-production"
    case preProduction = "pre-production"
}

enum TypeEnum: String, Codable {
    case animatedSeries = "animated-series"
    case anime = "anime"
    case cartoon = "cartoon"
    case movie = "movie"
    case tvSeries = "tv-series"
}

// MARK: - Videos
struct Videos: Codable {
    let trailers: [Trailer]?
}

// MARK: - Trailer
struct Trailer: Codable {
    let url: String?
    let name, site: String?
    let size: Int?
    let type: String?
}

// MARK: - Votes
struct Votes: Codable {
    let kp: Kp?
    let imdb, filmCritics, russianFilmCritics, votesAwait: Int?
    let tmdb: Int?

    enum CodingKeys: String, CodingKey {
        case kp, imdb, filmCritics, russianFilmCritics
        case votesAwait
        case tmdb
    }
}

enum Kp: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Kp.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Kp"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Watchability
struct Watchability: Codable {
    let items: [WatchabilityItem]?
}

// MARK: - WatchabilityItem
struct WatchabilityItem: Codable {
    let name: String?
    let logo: Logo?
    let url: String?
}
