//
//  RepositoryListViewModelTests.swift
//  LetsTest-GitHubSearchTests
//
//  Created by 윤중현 on 2022/11/22.
//

import XCTest
@testable import LetsTest_GitHubSearch

final class RepositoryListViewModelTests: XCTestCase {

    /**
     * 입력한 키워드로 검색하고 검색 결과를 화면에 표시합니다.
     */
    func testSearch() {
        // given
        let viewModel = RepositoryListViewModel(
            repositorySearchService: RepositorySearchServiceStub()
        )
        let delegate = DelegateStub()
        viewModel.delegate = delegate

        // when
        viewModel.search(repositoryName: "ReactorKit")

        // then
        XCTAssertTrue(delegate.receivedValue?.contains(where: { repository in repository.name == "ReactorKit" }) == true)
    }

}

private final class DelegateStub: RepositoryListViewModelDelegate {
    func setLoading(_ isLoading: Bool) {

    }

    var receivedValue: [Repository]?
    func showRepositories(_ repositories: [Repository]) {
        receivedValue = repositories
    }
}

private final class RepositorySearchServiceStub: RepositorySearchServiceType {
    func searchRepositories(by name: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        completion(.success([Repository(name: "ReactorKit", stargazersCount: 10000)]))
    }
}
