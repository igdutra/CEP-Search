//
//  CEPInfoView.swift
//  CEPiOS
//
//  Created by Ivo on 30/01/24.
//

import UIKit

final class CepInfoView: UIView {
    private lazy var titleLabel = UILabel()
    private lazy var infoLabel = UILabel()

    init(title: String, info: String) {
        super.init(frame: .zero)
        setupViews()
        configure(with: title, info: info)
        setupConstraints()
    }

    required init?(coder: NSCoder) { nil }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(infoLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .gray

        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4), // Fix added space by the different fonts
            titleLabel.trailingAnchor.constraint(equalTo: infoLabel.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(with title: String, info: String) {
        titleLabel.text = title
        infoLabel.text = info
    }
}
