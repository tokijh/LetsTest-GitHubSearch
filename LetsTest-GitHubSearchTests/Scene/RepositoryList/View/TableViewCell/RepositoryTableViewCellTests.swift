//
//  RepositoryTableViewCellTests.swift
//  LetsTest-GitHubSearchTests
//
//  Created by 윤중현 on 2022/11/22.
//

import XCTest
@testable import LetsTest_GitHubSearch

final class RepositoryTableViewCellTests: XCTestCase {

    /**
     * Repository 를 설정하면 star 수를 표시합니다.
     */
    func testStarCountLabel() {
        // given
        let cell = RepositoryTableViewCell()

        // when
        cell.setRepository(Repository(name: "ReactorKit", stargazersCount: 12345))

        // then
        XCTAssertEqual(cell.starCountLabel.text, "12,345 개")
    }

}
