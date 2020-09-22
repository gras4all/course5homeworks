//
//  ReposHeaderView.swift
//  Course5Homework
//
//  Created by Андрей Груненков on 19.09.2020.
//  Copyright © 2020 Андрей Груненков. All rights reserved.
//

import UIKit

class ReposHeaderView: UIView {
    
    private let inset: CGFloat = 16.0
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureTitle(_ title: String) {
        titleLabel.text = title
    }
}

private extension ReposHeaderView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: inset),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: (-1) * inset),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: (-1) * inset),
        ])
    }
}

