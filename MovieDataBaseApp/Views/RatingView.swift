//
//  RatingView.swift
//  MovieDataBaseApp
//
//  Created by Ashutosh Bisht on 28/07/24.
//

import UIKit

class RatingView: UIView {
    private let ratingLabel = UILabel()

    var rating: String? {
        didSet {
            ratingLabel.text = rating
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        ratingLabel.textAlignment = .center
        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        addSubview(ratingLabel)

        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
