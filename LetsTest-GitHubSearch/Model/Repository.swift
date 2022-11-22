//
//  Repository.swift
//  LetsTest-GitHubSearch
//
//  Created by 윤중현 on 2022/11/22.
//

struct Repository: Hashable, Codable {
    let name: String
    let stargazersCount: Int

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case stargazersCount = "stargazers_count"
    }
}
