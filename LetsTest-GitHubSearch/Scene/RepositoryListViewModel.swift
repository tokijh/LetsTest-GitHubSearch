//
//  RepositoryListViewModel.swift
//  LetsTest-GitHubSearch
//
//  Created by 윤중현 on 2022/11/22.
//

import Foundation

protocol RepositoryListViewModelAction {
    func search(repositoryName: String)
}

protocol RepositoryListViewModelDelegate: AnyObject {
    func setLoading(_ isLoading: Bool)
    func showRepositories(_ repositories: [Repository])
}

protocol RepositoryListViewModelType: AnyObject, RepositoryListViewModelAction {

    typealias Delegate = RepositoryListViewModelDelegate

    var delegate: Delegate? { get set }

}

final class RepositoryListViewModel: RepositoryListViewModelType {

    // MARK: Property

    weak var delegate: Delegate?

    private let repositorySearchService: RepositorySearchServiceType


    // MARK: Initializer

    init(repositorySearchService: RepositorySearchServiceType) {
        self.repositorySearchService = repositorySearchService
    }


    // MARK: Action

    func search(repositoryName: String) {
        delegate?.setLoading(true)
        repositorySearchService.searchRepositories(by: repositoryName) { result in
            switch result {
            case let .success(repositories):
                self.delegate?.showRepositories(repositories)
                self.delegate?.setLoading(false)

            case .failure:
                self.delegate?.setLoading(false)
            }
        }
    }

}
