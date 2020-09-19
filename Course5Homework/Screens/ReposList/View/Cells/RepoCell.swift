//
//  RepoCell.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 15.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class RepoCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let avatarImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    func bindData(_ repo: Repo) {
        titleLabel.text = repo.name
        descriptionLabel.text = repo.description
        usernameLabel.text = repo.owner.login
        avatarImage.kf.setImage(with: URL(string: repo.owner.avatarUrl))
    }

}

extension RepoCell {
    
    func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(avatarImage)
        self.selectionStyle = .gray
        self.backgroundColor = .clear
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: avatarImage.leadingAnchor, constant: -16),
            usernameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            usernameLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            usernameLabel.widthAnchor.constraint(equalToConstant: 50),
            avatarImage.heightAnchor.constraint(equalToConstant: 50),
            avatarImage.widthAnchor.constraint(equalToConstant: 50),
            avatarImage.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
           
        ])
    }
    
}

