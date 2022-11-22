//
//  RepositoryListViewControllerTests.swift
//  LetsTest-GitHubSearchTests
//
//  Created by 윤중현 on 2022/11/22.
//

import XCTest
@testable import LetsTest_GitHubSearch

final class RepositoryListViewControllerTests: XCTestCase {

    /**
     * Repository 목록을 가져와 TableView 에 표시합니다.
     */
    func testShowRepositories() {
        // given
        let viewController = RepositoryListViewController(
            viewModel: ViewModelStub()
        )

        viewController.loadViewIfNeeded() // View 를 로드함
        viewController.view.layoutIfNeeded() // AutoLayout 을 view 에 반영함

        // when
        viewController.showRepositories([
            Repository(name: "ReactorKit", stargazersCount: 1234),
            Repository(name: "RxSwift", stargazersCount: 3456),
        ])

        XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1) // DispatchQueue.main.async 를 기다림

        // then
        let tableView = viewController.testables[\.tableView]
        let firstRowCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RepositoryTableViewCell
        let secondRowCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? RepositoryTableViewCell
        XCTAssertEqual(firstRowCell?.nameLabel.text, "ReactorKit")
        XCTAssertEqual(secondRowCell?.nameLabel.text, "RxSwift")
    }

    /**
     * 검색 버튼을 누르면 입력한 키워드로 검색 합니다.
     */
    func testClickSearchButton() {
        // given
        let viewModel = ViewModelStub()
        let viewController = RepositoryListViewController(
            viewModel: viewModel
        )
        let searchBar = viewController.searchController.searchBar

        viewController.loadViewIfNeeded() // View 를 로드함

        searchBar.text = "ReactorKit" // 키워드 설정

        // when
        searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)

        // then
        XCTAssertEqual(viewModel.receivedArgument, "ReactorKit")
    }

    /**
     * 화면에 표시된 Repository 를 누르면 Alert 에 내용을 표시합니다.
     */
    func testClickRepositoryCell() {
        // given
        let viewController = RepositoryListViewController(
            viewModel: ViewModelStub()
        )

        // ViewController.present() 테스트를 위해 화면에 표시된 것 처럼 위장함
        let window = UIWindow(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        viewController.loadViewIfNeeded() // View 를 로드함
        viewController.view.layoutIfNeeded() // AutoLayout 을 view 에 반영함

        // Repository 를 설정함
        viewController.showRepositories([
            Repository(name: "ReactorKit", stargazersCount: 1234),
        ])

        XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1) // Repositories 가 설정될 때까지 기다림

        // when
        let tableView = viewController.tableView
        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

        // then
        let alertController = viewController.presentedViewController as? UIAlertController
        XCTAssertEqual(alertController?.title, "ReactorKit")
        XCTAssertEqual(alertController?.message, "1,234 개")
    }
}

private final class ViewModelStub: RepositoryListViewModelType {
    var delegate: Delegate?

    var receivedArgument: String?
    func search(repositoryName: String) {
        receivedArgument = repositoryName
    }
}
