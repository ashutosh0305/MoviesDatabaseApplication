//
//  MovieTableViewCell.swift
//  MovieDataBaseApp
//
//  Created by Ashutosh Bisht on 28/07/24.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView? {
        didSet {
            moviePoster?.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var movieTitle: UILabel! {
        didSet {
            movieTitle.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            movieTitle.textColor = .black
        }
    }
    @IBOutlet weak var movieLanguages: UILabel! {
        didSet {
            movieLanguages.font = UIFont.systemFont(ofSize: 16)
            movieLanguages.textColor = .darkGray
            movieLanguages.numberOfLines = 2
        }
    }
    @IBOutlet weak var movieYear: UILabel! {
        didSet {
            movieYear.font = UIFont.systemFont(ofSize: 16)
            movieYear.textColor = .darkGray
            movieYear.numberOfLines = 3
        }
    }
    
    func setUpMoviesDataWithUI(movie: Movie) {
        movieTitle.text = movie.title
        
        let targetAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.darkGray
        ]
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.darkGray
        ]
        
        let yearText = "Year: \(movie.year)"
        movieYear.attributedText = NSAttributedString.createStyledAttributedString(
            fullText: yearText,
            targetTexts: ["Year: "],
            targetAttributes: targetAttributes,
            defaultAttributes: defaultAttributes
        )

        moviePoster?.image = movie.posterImage
        let languageText = "Language: \(movie.language)"
        movieLanguages.attributedText = NSAttributedString.createStyledAttributedString(
            fullText: languageText,
            targetTexts: ["Language: "],
            targetAttributes: targetAttributes,
            defaultAttributes: defaultAttributes
        )
    }
}
