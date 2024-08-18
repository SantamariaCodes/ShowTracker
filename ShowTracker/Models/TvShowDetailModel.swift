struct TvShowDetail: Codable {
    let id: Int
    let name: String
    let overview: String
    let firstAirDate: String?
    let genres: [Genre]?
    let numberOfEpisodes: Int?
    let numberOfSeasons: Int?
    let seasons: [Season]?
    let homepage: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview, genres, homepage
        case firstAirDate = "first_air_date"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case seasons
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct Season: Codable {
    let id: Int
    let name: String
    let airDate: String?
    let episodeCount: Int?
    let overview: String?
    let posterPath: String?
    let seasonNumber: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
