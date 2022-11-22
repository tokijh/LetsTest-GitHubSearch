//
//  GitHubRepositorySearchService.swift
//  LetsTest-GitHubSearch
//
//  Created by 윤중현 on 2022/11/22.
//

import Foundation

final class GitHubRepositorySearchService {

    static let shared = GitHubRepositorySearchService()

    func searchRepositories(by name: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        Task {
            do {
                let url = createSearchRepositoryByNameURL(name: name)
                let (data, _) = try await URLSession.shared.data(from: url)
                let result = try JSONDecoder().decode(RepositorySearchResult.self, from: data)
                completion(.success(result.items))
            } catch {
                completion(.failure(error))
            }
        }
    }

    private func createSearchRepositoryByNameURL(name: String) -> URL {
        URL(string: "https://api.github.com/search/repositories?q=\(name)")!
    }

}
