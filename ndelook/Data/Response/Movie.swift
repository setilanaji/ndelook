//
//  Movie.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

// MARK: - Movie Discover
struct MovieDiscoverResponse: Codable, DomainModel {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func toDomain() -> MovieDiscoverDomain {
        MovieDiscoverDomain(
            adult: adult ?? false,
            backdropPath: backdropPath ?? "",
            genreIDS: genreIDS ?? [],
            id: id ?? 0,
            originalTitle: originalTitle ?? "",
            overview: overview ?? "",
            popularity: popularity ?? 0,
            posterPath: posterPath ?? "",
            releaseDate: releaseDate ?? "",
            title: title ?? "",
            video: video ?? false,
            voteAverage: voteAverage ?? 0,
            voteCount: voteCount ?? 0
        )
    }
}

// MARK: - Movie Details
struct MovieDetailResponse: Codable, DomainModel {
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [GenreResponse]?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompanyResponse]?
    let productionCountries: [ProductionCountryResponse]?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguageResponse]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func toDomain() -> MovieDetailDomain {
        MovieDetailDomain(
            adult: adult ?? false,
            backdropPath: backdropPath ?? "",
            budget: budget ?? 0,
            genres: (genres ?? []).map { $0.toDomain() },
            homepage: homepage ?? "",
            id: id ?? 0,
            imdbID: imdbID ?? "",
            originalLanguage: originalLanguage ?? "",
            originalTitle: originalTitle ?? "",
            overview: overview ?? "",
            popularity: popularity ?? 0,
            posterPath: posterPath ?? "",
            productionCompanies: (productionCompanies ?? []).map { $0.toDomain() },
            productionCountries: (productionCountries ?? []).map { $0.toDomain() },
            releaseDate: releaseDate ?? "",
            revenue: revenue ?? 0,
            runtime: runtime ?? 0,
            spokenLanguages: (spokenLanguages ?? []).map { $0.toDomain() },
            status: status ?? "",
            tagline: tagline ?? "",
            title: title ?? "",
            video: video ?? false,
            voteAverage: voteAverage ?? 0,
            voteCount: voteCount ?? 0
        )
    }
}

// MARK: - ProductionCompany
struct ProductionCompanyResponse: Codable, DomainModel {
    let id: Int?
    let logoPath, name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    func toDomain() -> ProductionCompanyDomain {
        ProductionCompanyDomain(
            id: 0,
            logoPath: "",
            name: "",
            originCountry: ""
        )
    }
}

// MARK: - ProductionCountry
struct ProductionCountryResponse: Codable, DomainModel {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
    
    func toDomain() -> ProductionCountryDomain {
        ProductionCountryDomain(
            iso3166_1: iso3166_1 ?? "",
            name: name ?? ""
        )
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguageResponse: Codable, DomainModel {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
    
    func toDomain() -> SpokenLanguageDomain {
        SpokenLanguageDomain(
            englishName: englishName ?? "",
            iso639_1: iso639_1 ?? "",
            name: name ?? ""
        )
    }
}
