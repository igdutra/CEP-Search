//
//  CEPDetailsViewController.swift
//  CEPiOS
//
//  Created by Ivo on 28/01/24.
//

import UIKit
import CEPSearch

public final class CEPDetailsViewController: UIViewController {
    private let cepDetails: CEPDetails

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var cepLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var districtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private lazy var cityStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    public init(cepDetails: CEPDetails) {
        self.cepDetails = cepDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayDetails()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupLabels()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupLabels() {
        [cepLabel, addressLabel, districtLabel, cityStateLabel].forEach {
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            cepLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cepLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cepLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            addressLabel.topAnchor.constraint(equalTo: cepLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            districtLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            districtLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            districtLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            cityStateLabel.topAnchor.constraint(equalTo: districtLabel.bottomAnchor, constant: 8),
            cityStateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cityStateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cityStateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func displayDetails() {
        title = "CEP: \(cepDetails.cep)"
        cepLabel.text = "CEP: \(cepDetails.cep)"

        let addressComplement = cepDetails.complement.isEmpty ? cepDetails.street : "\(cepDetails.street), \(cepDetails.complement)"
        addressLabel.text = "Address: \(addressComplement)"

        districtLabel.text = "District: \(cepDetails.district)"
        cityStateLabel.text = "City/State: \(cepDetails.city), \(cepDetails.state)"
    }
}

