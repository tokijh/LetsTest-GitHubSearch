//
//  RepositorySearchResult.swift
//  LetsTest-GitHubSearch
//
//  Created by 윤중현 on 2022/11/22.
//

struct RepositorySearchResult: Codable {
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case items
    }
}
