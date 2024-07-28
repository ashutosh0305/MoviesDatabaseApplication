//
//  MovieDetailsViewController.swift
//  MovieDataBaseApp
//
//  Created by Ashutosh Bisht on 28/07/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let plotLabel = UILabel()
    private let castAndCrewLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let genreLabel = UILabel()
    private let ratingControl = UISegmentedControl()
    private let ratingView = RatingView()

    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        if let movie = movie {
            configure(with: movie)
        }
    }

    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        posterImageView.contentMode = .scaleAspectFit
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(posterImageView)

        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        plotLabel.font = UIFont.systemFont(ofSize: 16)
        plotLabel.numberOfLines = 0
        plotLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(plotLabel)

        castAndCrewLabel.font = UIFont.systemFont(ofSize: 16)
        castAndCrewLabel.numberOfLines = 0
        castAndCrewLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(castAndCrewLabel)

        releaseDateLabel.font = UIFont.systemFont(ofSize: 16)
        releaseDateLabel.numberOfLines = 0
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(releaseDateLabel)

        genreLabel.font = UIFont.systemFont(ofSize: 16)
        genreLabel.numberOfLines = 0
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(genreLabel)

        ratingControl.addTarget(self, action: #selector(ratingSourceChanged(_:)), for: .valueChanged)
        ratingControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ratingControl)

        ratingView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ratingView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            posterImageView.heightAnchor.constraint(equalToConstant: 300),

            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            plotLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            plotLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            plotLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            castAndCrewLabel.topAnchor.constraint(equalTo: plotLabel.bottomAnchor, constant: 20),
            castAndCrewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            castAndCrewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            releaseDateLabel.topAnchor.constraint(equalTo: castAndCrewLabel.bottomAnchor, constant: 20),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            genreLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 20),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            ratingControl.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 20),
            ratingControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ratingControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            ratingView.topAnchor.constraint(equalTo: ratingControl.bottomAnchor, constant: 20),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            ratingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            ratingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            ratingView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configure(with movie: Movie) {
        titleLabel.text = movie.title
        plotLabel.text = movie.plot

        let targetAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18),
            .foregroundColor: UIColor.darkText
        ]
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ]

        let castAndCrewText = "Cast & Crew: \(movie.actors)"
        castAndCrewLabel.attributedText = NSAttributedString.createStyledAttributedString(
            fullText: castAndCrewText,
            targetTexts: ["Cast & Crew: "],
            targetAttributes: targetAttributes,
            defaultAttributes: defaultAttributes
        )

        let releaseDateText = "Release Year: \(movie.year)"
        releaseDateLabel.attributedText = NSAttributedString.createStyledAttributedString(
            fullText: releaseDateText,
            targetTexts: ["Release Year: "],
            targetAttributes: targetAttributes,
            defaultAttributes: defaultAttributes
        )

        let genreText = "Genre: \(movie.genre)"
        genreLabel.attributedText = NSAttributedString.createStyledAttributedString(
            fullText: genreText,
            targetTexts: ["Genre: "],
            targetAttributes: targetAttributes,
            defaultAttributes: defaultAttributes
        )

        posterImageView.image = movie.posterImage
        configureRatingControl(with: movie.ratings)
    }

    private func configureRatingControl(with ratings: [Rating]) {
        ratingControl.removeAllSegments()
        for (index, rating) in ratings.enumerated() {
            ratingControl.insertSegment(withTitle: rating.Source, at: index, animated: false)
        }
        ratingControl.selectedSegmentIndex = 0
        updateRatingView()
    }

    @objc private func ratingSourceChanged(_ sender: UISegmentedControl) {
        updateRatingView()
    }

    private func updateRatingView() {
        guard let selectedSource = ratingControl.titleForSegment(at: ratingControl.selectedSegmentIndex) else {
            return
        }
        let rating = movie?.ratings.first { $0.Source == selectedSource }
        ratingView.rating = rating?.Value
    }
}

