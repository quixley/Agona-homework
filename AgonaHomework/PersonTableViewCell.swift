//
//  PersonTableViewCell.swift
//  AgonaHomework
//
//  Created by Artur on 07.03.2024.
//

import Foundation
import UIKit
import SnapKit

class PersonTableViewCell: UITableViewCell {
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            avatarImageView,
            nameLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 16.0
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(Constants.imageSize)
        }
    }

    func configure(with person: Person) {
        nameLabel.text = person.name
        avatarImageView.backgroundColor = .gray
    }
}

private enum Constants {
    static let imageSize: CGSize = .init(width: 40, height: 40)
}
