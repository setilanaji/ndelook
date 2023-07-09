//
//  MovieDetailDomain.swift
//  ndelook
//
//  Created by Yudha S on 08/07/23.
//

import Foundation

// MARK: - Movie Details
struct MovieDetailDomain {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [GenreDomain]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompanyDomain]
    let productionCountries: [ProductionCountryDomain]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguageDomain]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var releasedYear: String {
        return releaseDate.formatDate(from: "yyyy-MM-dd", to: "yyyy") ?? releaseDate
    }
    
    var languages: String {
        if spokenLanguages.count > 1 {
            return spokenLanguages.count.toString() + " Languages"
        } else {
            return spokenLanguages.first?.englishName ?? ""
        }
    }
    
    var infos: String {
        [
            releasedYear,
            runtime.minutesToHoursMinutes(),
            languages
        ]
            .filter { !$0.isEmpty }
            .joined(separator: " • ")
    }
    
    var genresString: String {
        return genres.map(\.name).joined(separator: " | ")
    }
    
    static let empty: MovieDetailDomain =
        .init(
            adult: false,
            backdropPath: "",
            budget: 0,
            genres: [],
            homepage: "",
            id: 0,
            imdbID: "",
            originalLanguage: "",
            originalTitle: "",
            overview: "",
            popularity: 0,
            posterPath: "",
            productionCompanies: [],
            productionCountries: [],
            releaseDate: "",
            revenue: 0,
            runtime: 0,
            spokenLanguages: [],
            status: "",
            tagline: "",
            title: "",
            video: false,
            voteAverage: 0,
            voteCount: 0
        )
}

// MARK: - ProductionCompany
struct ProductionCompanyDomain {
    let id: Int
    let logoPath, name, originCountry: String
    
    static let empty: ProductionCompanyDomain =
        .init(id: 0, logoPath: "", name: "", originCountry: "")
}

// MARK: - ProductionCountry
struct ProductionCountryDomain {
    let iso3166_1, name: String
    
    static let empty: ProductionCountryDomain =
        .init(iso3166_1: "", name: "")
}

// MARK: - SpokenLanguage
struct SpokenLanguageDomain {
    let englishName, iso639_1, name: String
    
    static let empty: SpokenLanguageDomain =
        .init(englishName: "", iso639_1: "", name: "")
}
