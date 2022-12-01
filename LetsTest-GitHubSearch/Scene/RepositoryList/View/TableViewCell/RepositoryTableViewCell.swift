//
//  RepositoryTableViewCell.swift
//  LetsTest-GitHubSearch
//
//  Created by 윤중현 on 2022/11/22.
//

import UIKit

final class RepositoryTableViewCell: UITableViewCell {

    private enum Formatter {
        static func starCountNumber(_ starCount: Int) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: starCount))!
        }
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        return label
    }()
    let starImageView = UIImageView(image: UIImage(systemName: "star"))
    let starCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        addSubview(nameLabel)
        addSubview(starImageView)
        addSubview(starCountLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starCountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 24),

            starImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            starImageView.centerYAnchor.constraint(equalTo: starCountLabel.centerYAnchor),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            starImageView.heightAnchor.constraint(equalToConstant: 16),

            starCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            starCountLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4),
            starCountLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 24),
            starCountLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }

    func setRepository(_ repository: Repository) {
        nameLabel.text = repository.name
        let formattedStarCount = Formatter.starCountNumber(repository.stargazersCount)
        starCountLabel.text = "\(formattedStarCount) 개"
    }

}
